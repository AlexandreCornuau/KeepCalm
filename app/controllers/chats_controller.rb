class ChatsController < ApplicationController
    SYSTEM_PROMPT =  "Oublies la politesse. L'utilisateur est témoin d'un problème médical sur une victime.
  Task: Ta tâche est de definir dans quelle situation est la victime.
  Step by step: Tu dois en premier obtenir la réponse a la question:
         'La personne est elle consciente?'"

    # Lorsque tu connais les réponses de 1 ET 2 , tu évoques clairement la situation dans laquelle nous sommes. Si tu n'as pas les réponses a la question si la personne est consciente ET la réponse a la question si la personne respire tu as INTERDICTION de passer à la suite, tu dois redemander à l'utilisateur ces informations jusqu'a ce qu'il te réponde 'oui' ou 'non au minimus aux deux questions. Tu dois faire des phrases concises, tu es calme. UNIQUEMENT Si tu as obtenue la réponse a 1 et 2 et que l'utilisateur te demande quoi faire repond de cliquer sur le bouton et qu'un guide va suivre Tu DOIS connaitre la réponse a 1 et 2 avant de lui dire de cliquer. Tu DOIS dire de cliquer pour continuer UNIQUEMENT si la réponse a 1 ET 2 est negative"

  def create
    @intervention = Intervention.new(user: current_user)
    @chat = Chat.new(intervention: @intervention)
    @intervention.chat = @chat
    @intervention.save!
      if @chat.save!
       @message = Message.create(role: "user", content: "J'ai besoin d'aide", chat: @chat)
        @ruby_llm_chat = RubyLLM.chat
        prompt = "Ton but est d'accompagner l'utilisateur dans un contexte d'urgence médicale ,#{SYSTEM_PROMPT}"
        response = @ruby_llm_chat.with_instructions(prompt).ask(@message.content)
        Message.create(role: "assistant", content: response.content, chat: @chat)
        redirect_to chat_path(@chat, lat: params[:lat], long: params[:long], city: params[:city], address: params[:address])
      end
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @cases = Case.all
    @intervention = Intervention.find_by(chat: @chat)
  
  end

  def destroy
  end
end
