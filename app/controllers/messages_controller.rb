class MessagesController < ApplicationController
  SYSTEM_PROMPT =  <<-PROMPT
  Oublies la politesse. Tu es la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical.

  Tu dois obtenir la réponse a deux questions: 1 = La personne est elle consciente? 2 = La personne respire t'elle?
  Lorsque tu connais les réponses de 1 ET 2 , tu évoques clairement la situation dans laquelle nous sommes.
  Tu dois faire des phrases concises, tu es calme.

  UNIQUEMENT dans le cadre ou la personne n'est pas consciente et ne respire pas, Tu DOIS dire que c'est un arrêt cardiaque et inciter l'utilisateur a cliquer sur continuer pour acceder aux instructions.


   UNIQUEMENT Si une des deux est positive, ce n'est pas un arrêt cardiaque, repond 'Appelez le 15 ils vont vous guider'
  PROMPT

  PROMPT_NO_CONSCIENS = <<-PROMPT
  Oublies la politesse. Tu es la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical.
  La victime est inconsciente.
  Tu dois IMPERATIVEMENT demander 'Est ce qu'elle respire?'
  Tu as l'interdiction de répondre à l'utilisateur tant qu'il ne t'as pas répondu oui ou non.

  Si la personne respire: cool

  Si la personne ne respire pas tu dois OBLIGATOIREMENT Repondre 'c'est un arrêt cardiaque. L'application vas vous guider pour les manoeuvre de secours, appelez ou faites appelez le 15'
  PROMPT
  PROMPT_AWAKE = <<-PROMPT
   Oublies la politesse. Tu es la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical.
  La victime est consciente.
  Tu dois répondre IMPERATIVEMENT 'Si la personne est consciente ne la touchez pas et appeler le 15'
  PROMPT
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @cases = Case.all
    if @message.save
      user = @chat.messages.where(role: "user")
      #premier message ejecté avec reject
      user_messages = user.reject{|message| message.content == "j'ai besoin d'aide"}
      if user_messages.first.content.downcase == "non"
        #--> personne inconsciente --> declencher nouveau prompt
        @ruby_llm_chat = RubyLLM.chat
        build_conversation_history
        prompt = PROMPT_NO_CONSCIENS
        #nouveau prompt oriente directement sur l'arret cardiaque en cas de non respiration
        response = @ruby_llm_chat.with_instructions(PROMPT_NO_CONSCIENS).ask(@message.content)
        Message.create(role: "assistant", content: response.content, chat: @chat)
        # redirect_to chat_path(@chat)

      else  #premier message.downcase == oui --> personne consciente --> déclencher nouveau prompt
        #nouveau prompt oriente sur la surveillance de la respiration/autre probleme
        @ruby_llm_chat = RubyLLM.chat
        build_conversation_history
        prompt = PROMPT_NO_CONSCIENS
        #nouveau prompt oriente directement sur l'arret cardiaque en cas de non respiration
        response = @ruby_llm_chat.with_instructions(PROMPT_AWAKE).ask(@message.content)
        Message.create(role: "assistant", content: response.content, chat: @chat)
        #redirect_to chat_path(@chat)
      end

      # @ruby_llm_chat = RubyLLM.chat
      # build_conversation_history
      # prompt = "#{emmergency_case},#{SYSTEM_PROMPT}"
      # response = @ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      # Message.create(role: "assistant", content: response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_content
    end
  end


  private
  def message_params
    params.require(:message).permit(:content)
  end

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(message)
    end
  end





  def emmergency_case
    @choice = [] # Le but est que le chat puisse choisir la bonne urgence, PEUT ETRE faire un hash dans lequel on stock l'ID de l'urgence et plus tard on s'en sert pour afficher la show de la bonne case.
    @cases.each do |emergency|
      @choice << emergency.name
    end
    @choice = @choice.join(" ")
    "Ton but est de determiner de quelle situation parmis:#{@choice} et uniquement parmis #{@choice} Tu dois enoncer clairement dans quelle #{@choice} nous sommes"
  end
end
