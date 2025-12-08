class PagesController < ApplicationController

  def home
   @chat = Chat.new
   getCity()
   setUpMap()
   getDaes()
  end

end
