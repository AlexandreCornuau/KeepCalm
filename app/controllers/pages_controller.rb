class PagesController < ApplicationController

  def home
   @chat = Chat.new
   if params[:city] && params[:long] && params[:lat]
    getCity()
    setUpMap()
    getDaes()
   end
  end

end
