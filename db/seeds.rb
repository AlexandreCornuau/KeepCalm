# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Case.destroy_all
Step.destroy_all

case1 = Case.create!(name: "massage cardiaque", gif_url: "https://upload.wikimedia.org/wikipedia/commons/d/df/Chest_compressions.gif")

step0 = Step.create!(step_type: "information", case: case1, details: "<p> Installez la victime en <b>position horizontale</b>, sur le <b>dos</b>, de préférence sur un <b>plan dur</b> (sol, table, etc).</p>")

step1 = Step.create!(step_type: "instruction", number: 1, case: case1, details: "Se placer à genoux au plus près de la victime sur son coté", picture_url: "https://www.espacesoignant.com/files/img/articles/soins/compressions-thoraciques-1.png")

step2 = Step.create!(step_type: "instruction", number: 2, case: case1, details: "Dénuder la poitrine de la victime, dans la mesure du possible")

step3 = Step.create!(step_type: "instruction", number: 3, case: case1, details: "Joignez vos mains comme ceci:", picture_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJIPuHmmqdWde7lOh3_-GFCzvxQ-8reE1RDQ&s")

step4 = Step.create!(step_type: "information", case: case1, details: "<ul><li> Appuyer verticalement </li><li> Garder le dos droit </li><li> Garder les bras tendus </li></ul><p><b>Rythme</b> : Entre 100 et 120 compressions <b>par minute</b></p>")
