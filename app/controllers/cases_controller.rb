class CasesController < ApplicationController
  def show
    @case = Case.find(params[:id])
    @steps = @case.steps
    @intervention = Intervention.find(params[:intervention_id])
    @intervention.update(case: @case) unless @intervention.case.present?
  end

  def index
  end
end
