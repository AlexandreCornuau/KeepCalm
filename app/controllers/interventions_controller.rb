require "json"

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

  private

  def dae_token
    response = HTTParty.post(
      "https://api-geodae.sante.gouv.fr/api/login",
      body: {
        username: ENV["GEODAE_USERNAME"],
        password: ENV["GEODAE_PASSWORD"]
      }.to_json,
      headers: { "Content-Type" => "application/json" }
    )
    response["token"]
  end

  def
    token = dae_token
    response = HTTParty.get("https://api-geodae.sante.gouv.fr/api/dae",
      query: { offset: 0, _where: "and(eq(com_nom,Nantes),eq(etat_fonct,En fonctionnement),eq(etat_valid,validées))" },
      headers: { "Authorization" => "Bearer #{token}" }
      )
    response.parsed_response
    
  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
