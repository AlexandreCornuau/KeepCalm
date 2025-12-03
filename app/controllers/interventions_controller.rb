require "json"

class InterventionsController < ApplicationController

  def create

  end

  def show
  end

  def recap
  end

  def index
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
  end
end
