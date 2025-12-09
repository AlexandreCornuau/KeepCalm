class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def getCity
    @city = params[:city]
  end
  def setUpMap
    daes_list(@city)
    puts "setupmap ok"
  end

  def getDaes
    @daes = Dae.near([params[:lat], params[:long]], 1)
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

    puts all_daes

    if all_daes.is_a?(Hash) || all_daes.is_a?(Array)
      puts "c'est du JSON valide"
      all_daes.each do |dae|
        Dae.find_or_create_by(
          lat: dae["latCoor1"],
          long: dae["longCoor1"],
          street: dae["adrVoie"],
          postcode: dae["comCp"],
          city: dae["comNom"]
          )
      end
    else
      puts "ce n'est pas du JSON valide"
    end

  end
end
