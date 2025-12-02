class CasesController < ApplicationController
  def show
    @case = Case.find(params[:id])
    @steps = @case.steps
  end

  def index
  end
end
