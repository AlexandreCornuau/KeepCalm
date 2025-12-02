class InterventionsController < ApplicationController
  def index
    @interventions = Intervention.all
  end

  def show
    @intervention = Intervention.find(params[:id])
  end

  def create
    @intervention = Intervention.new(intervention_params)
    @intervention.save
  end

  def recap
  end

private

  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
