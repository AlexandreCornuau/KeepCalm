class ChatsController < ApplicationController
  def create
    @intervention = Intervention.new(user: current_user)
    @chat = Chat.new(intervention: @intervention)
    @intervention.chat = @chat
    @intervention.save!
      if @chat.save!
        redirect_to chat_path(@chat)
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
