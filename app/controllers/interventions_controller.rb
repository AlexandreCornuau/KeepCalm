require "json"

class InterventionsController < ApplicationController
    before_action :set_intervention, only: [:show, :update, :recap]

  def index
    @interventions = Intervention.all
  end

  def show
    @city = params[:city]
    @case = Case.find(params[:case_id])
    daes_list(@city)
    # @daes = Dae.where(city: @city)
    @daes = Dae.near([params[:lat], params[:long]], 1)

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

  def daes_list(city)
    token = dae_token
    response_capitalize = HTTParty.get("https://api-geodae.sante.gouv.fr/api/dae",
      query: { offset: 0, _where: "and(eq(com_nom,#{city.capitalize}),eq(etat_fonct,En fonctionnement),eq(etat_valid,validées))" },
      headers: { "Authorization" => "Bearer #{token}" }
      )

    response_downcase = HTTParty.get("https://api-geodae.sante.gouv.fr/api/dae",
    query: { offset: 0, _where: "and(eq(com_nom,#{city.downcase}),eq(etat_fonct,En fonctionnement),eq(etat_valid,validées))" },
    headers: { "Authorization" => "Bearer #{token}" }
    )

    all_daes = response_capitalize.parsed_response + response_downcase.parsed_response

    all_daes.each do |dae|
      Dae.find_or_create_by(
        lat: dae["latCoor1"],
        long: dae["longCoor1"],
        street: dae["adrVoie"],
        postcode: dae["comCp"],
        city: dae["comNom"]
        )
    end
  end

  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
