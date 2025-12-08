class PagesController < ApplicationController

  def home
   @chat = Chat.new
   setUpMap()
  end

end
