class ErrorsController < ApplicationController


 def internal_server
   render status: 500
 end

end
