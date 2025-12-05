puts "+++ Clean Case and Steps..."
Chat.destroy_all
Intervention.destroy_all
User.destroy_all
Case.destroy_all
Step.destroy_all

puts "——— Clean done ———"

last_step_info = "<div>
                    <ul>
                        <li> Appuyer verticalement </li>
                        <li> Garder le dos droit </li>
                        <li> Garder les bras tendus </li>
                    </ul>
                    <p><b>Rythme</b> : Entre 100 et 120 compressions <b>par minute</b></p>
                  </div>"

puts "+++ Creating Case and steps..."
case_rcp = Case.create(name: "Massage Cardiaque", gif_url: "rcp-video.gif")

puts "Step 0 infos"
Step.create!(step_type: "information", case: case_rcp, details: "<p> Installez la victime en <b>position horizontale</b>, sur le <b>dos</b>, de préférence sur un <b>plan dur</b> (sol, table, etc).</p>")

puts "Step 1"
Step.create!(step_type: "instruction", number: 1, case: case_rcp, details: "Se placer à genoux au plus près de la victime sur son coté", picture_url: "img-step-01.jpg")

puts "Step 2"
Step.create!(step_type: "instruction", number: 2, case: case_rcp, details: "Dénuder la poitrine de la victime, dans la mesure du possible")

puts "Step 3"
step3 = Step.create!(step_type: "instruction", number: 3, case: case_rcp, details: "Joignez vos mains comme ceci :", picture_url: "img-step-03.jpg")

puts "Step 4"
Step.create!(step_type: "instruction", number: 4, case: case_rcp, details: "Réaliser les compression au centre de la poitrine (sur la ligne médiane, moitié inférieure du sternum)", picture_url: "img-step-04.jpg")

puts "Step 5"
Step.create!(step_type: "instruction", number: 5, case: case_rcp, details: "Réaliser des compressions thoraciques", picture_url: "img-step-05.jpg")

puts "Last Step infos"
Step.create!(step_type: "information", case: case_rcp, details: last_step_info)

puts "——— All Seeds created ———"
