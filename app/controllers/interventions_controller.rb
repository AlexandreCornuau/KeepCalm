require "json"

class InterventionsController < ApplicationController
    before_action :set_intervention, only: [:show, :update, :recap]

  def index
    @interventions = Intervention.all
  end

  def show
    getCity()
    getDaes()
    @case = Case.find(params[:case_id])
    @intervention.address = params[:address]
    unless @intervention.start_time.present?
      now = Time.current
      @intervention.start_time ||= Time.zone.local(now.year, now.month, now.day, now.hour, now.min, now.sec)
    end
    @intervention.save
  end

  def update
    @intervention.update(intervention_params)
  end

  def recap
    @chat = @intervention.chat
    now = Time.current
    @intervention.end_time ||= Time.zone.local(now.year, now.month, now.day, now.hour, now.min, now.sec)
    @intervention.save
  end

private

  def set_intervention
    @intervention = Intervention.find(params[:id])
  end

  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
