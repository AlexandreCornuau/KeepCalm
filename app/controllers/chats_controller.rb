class ChatsController < ApplicationController
  def show
    @intervention = Intervention.new
    @chat = Chat.create(intervention: @intervention)
  end

  def destroy
  end
end
