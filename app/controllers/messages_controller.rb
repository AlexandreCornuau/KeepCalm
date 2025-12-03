class MessagesController < ApplicationController
  SYSTEM_PROMPT =  "Oublies la politesse. Tu es un la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical. Tu dois obtenir la réponse a deux questions: 1 = La personne est elle consciente? 2 = La personne respire t'elle? Lorsque tu connais les réponses de 1 ET 2 , tu évoques clairement la situation dans laquelle nous sommes. Si tu n'as pas les réponses a la question si la personne est consciente ET la réponse a la question si la personne respire tu as INTERDICTION de passer à la suite, tu dois redemander à l'utilisateur ces informations jusqu'a ce qu'il te réponde 'oui' ou 'non au minimus aux deux questions. Tu dois faire des phrases concises, tu es calme. UNIQUEMENT Si tu as obtenue la réponse a 1 et 2 et que l'utilisateur te demande quoi faire repond de cliquer sur le bouton et qu'un guide va suivre Tu DOIS connaitre la réponse a 1 et 2 avant de lui dire de cliquer. Tu DOIS dire de cliquer pour continuer UNIQUEMENT si la réponse a 1 ET 2 est negative"


  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @cases = Case.all
    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      prompt = "#{emmergency_case},#{SYSTEM_PROMPT}"
      response = @ruby_llm_chat.with_instructions(prompt).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
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
