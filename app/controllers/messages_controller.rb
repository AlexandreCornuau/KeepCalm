class MessagesController < ApplicationController
  SYSTEM_PROMPT = "Tu es un la pour orienter sur une décision. Quelqu'un vient d'avoir un problème médical. Tu dois obtenir la réponse a 2 questions: La personne est elle consciente? La personne respire t'elle? Si la personne est inconsciente et en apnée tu évoque clairement que nous sommes en situation d'arret cardiaque. Tu dois rassurer l'utilisateur"


  def create
   @chat = Chat.find(params[:chat_id])
   @message = Message.new(message_params)
   @message.chat = @chat
   @message.role = "user"
   if @message.save
    ruby_llm_chat = RubyLLM.chat
    response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
    Message.create(role: "assistant", content: response.content, chat: @chat)
  end
     redirect_to chat_path(@chat)

  #  else
  #   render "chats/show", status: :unprocessable_entity
  end


  private
  def message_params
    params.require(:message).permit(:content)
  end

end
