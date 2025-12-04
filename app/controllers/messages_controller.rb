class MessagesController < ApplicationController
  # SYSTEM_PROMPT =  <<-PROMPT
  # Oublies la politesse. Tu es la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical.

  # Tu dois obtenir la réponse a deux questions: 1 = La personne est elle consciente? 2 = La personne respire t'elle?
  # Lorsque tu connais les réponses de 1 ET 2 , tu évoques clairement la situation dans laquelle nous sommes.
  # Tu dois faire des phrases concises, tu es calme.

  # UNIQUEMENT dans le cadre ou la personne n'est pas consciente et ne respire pas, Tu DOIS dire que c'est un arrêt cardiaque et inciter l'utilisateur a cliquer sur continuer pour acceder aux instructions.


  #  UNIQUEMENT Si une des deux est positive, ce n'est pas un arrêt cardiaque, repond 'Appelez le 15 ils vont vous guider'
  # PROMPT

  #Tu as l'interdiction de répondre à l'utilisateur tant qu'il ne t'as pas répondu oui ou non.

  PROMPT_NO_CONSCIENS = <<-PROMPT
  Oublies la politesse. Tu es la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical.
  La victime est inconsciente.
  Tu dois IMPERATIVEMENT demander une premiere fois 'Est ce qu'elle respire?' TU dois poser cette question UNE seule et UNIQUE fois.

  Si l'utilisateur repond 'oui' tu dois IMPERATIVEMENT repondre 'appelez les secours et mettez la personne en Position Latérale de Sécurité '
  Si la personne ne respire pas tu dois OBLIGATOIREMENT Repondre 'Il s'agit d'un un arrêt cardiaque. Vous devez commencer un massage cardiaque. Restez calme, l'application vas vous guider pour les manoeuvre de secours.'
  PROMPT
  PROMPT_AWAKE = <<-PROMPT
   Oublies la politesse. Tu es la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical.
  La victime est consciente.
  Tu dois répondre IMPERATIVEMENT 'Si la personne est consciente ne la touchez pas si vous n'êtes pas formée et appeler le 15'
  PROMPT
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @cases = Case.all
    if @message.save
      user = @chat.messages.where(role: "user")
      #premier message "j'ai besoin d'aide" (celui généré automatiquement)ejecté avec .reject
      user_messages = user.reject{|message| message.content == "J'ai besoin d'aide"}
      if user_messages.first.content.downcase.strip == "non"
        #--> personne inconsciente --> declencher nouveau prompt
        @ruby_llm_chat = RubyLLM.chat
        build_conversation_history #--> sinon on boucle sur la question

        #nouveau prompt doit savaoir que la personne est inconsciente --> oriente directement sur l'arret cardiaque en cas de non respiration
        response = @ruby_llm_chat.with_instructions(PROMPT_NO_CONSCIENS).ask(@message.content)
        Message.create(role: "assistant", content: response.content, chat: @chat)


      else  #premier message.downcase == oui --> personne consciente --> déclencher nouveau prompt
        #nouveau prompt oriente sur la surveillance de la respiration --> on part sur un autre probleme
        @ruby_llm_chat = RubyLLM.chat
        build_conversation_history
        #nouveau prompt oriente  sur l'appel des secours nous ne sommes plus dans le cadre de l'arret cardio respi
        response = @ruby_llm_chat.with_instructions(PROMPT_AWAKE).ask(@message.content)
        Message.create(role: "assistant", content: response.content, chat: @chat)

      end
        #########code de initial sans essayer de fractionner le prompt##############################
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




######################## methode qui n'est actuellement pas utilisée, l'idee etait de donner la liste des eventuelle cases au LLM et qu'il choisisse la bonne....
  def emmergency_case
    @choice = [] # Le but est que le chat puisse choisir la bonne urgence, PEUT ETRE faire un hash dans lequel on stock l'ID de l'urgence et plus tard on s'en sert pour afficher la show de la bonne case.
    @cases.each do |emergency|
      @choice << emergency.name
    end
    @choice = @choice.join(" ")
    "Ton but est de determiner de quelle situation parmis:#{@choice} et uniquement parmis #{@choice} Tu dois enoncer clairement dans quelle #{@choice} nous sommes"
  end
end
