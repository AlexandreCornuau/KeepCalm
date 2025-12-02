class InterventionsController < ApplicationController
  def index
    @interventions = Intervention.all
  end

  def show
    @intervention = Intervention.find(params[:id])
  end

  def update
    @intervention = Intervention.find(params[:id])
    @intervention.update(intervention_params)
  end

  def recap
  end

private

  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
