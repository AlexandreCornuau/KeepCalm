class InterventionsController < ApplicationController
    before_action :set_intervention, only: [:show, :update, :recap]

  def index
    @interventions = Intervention.all
  end

  def show
    @case = Case.find(params[:id])
  end

  def update
    @intervention.update(intervention_params)
  end

  def recap
  end

private

  def set_intervention
    @intervention = Intervention.find(params[:id])
  end

  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
