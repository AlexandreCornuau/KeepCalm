puts "+++ Clean Case and Steps..."
Chat.destroy_all
Intervention.destroy_all
User.destroy_all
Case.destroy_all
Step.destroy_all

puts "——— Clean done ———"

last_step_info = "<div>
                    <p>Faites attention à:</p>
                    <ul>
                        <li> Appuyer verticalement </li>
                        <li> Garder le dos droit </li>
                        <li> Garder les bras tendus </li>
                    </ul>
                    <p><b>Rythme</b> : Entre <b>100 et 120</b> compressions par minute</p>
                  </div>"

puts "+++ Creating Case and steps..."
case_rcp = Case.create(name: "Arrêt cardiaque", gif_url: "https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTJ3Mm4ycnpxcHU3cGoyMTc4cnN3M3VibmYxOGF6cW9oMm4yMzZkZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/d07PtnTq0oVsk/giphy.gif")


puts "Step 0 infos"
Step.create!(step_type: "information", case: case_rcp, details: "<p> Installez la victime en <b>position horizontale</b>, sur le <b>dos</b>, de préférence sur un <b>plan dur</b> (sol, table, etc).</p>")

puts "Step 1"
Step.create!(step_type: "instruction", number: 1, case: case_rcp, details: "Agenouillez-vous au plus près de la victime sur son coté", picture_url: "https://res.cloudinary.com/dqohqi3zr/image/upload/position_jjj7uk?_a=BACAGSEv")

puts "Step 2"
Step.create!(step_type: "instruction", number: 2, case: case_rcp, details: "Si possible, dénudez la poitrine de la victime")

puts "Step 3"
Step.create!(step_type: "instruction", number: 3, case: case_rcp, details: "Déterminez la zone d'appui, juste en dessous du milieu du sternum:", picture_url: "https://res.cloudinary.com/dqohqi3zr/image/upload/v1765460546/3-zone_dj7egy.png")

puts "Step 4"
Step.create!(step_type: "instruction", number: 4, case: case_rcp, details: "Appuyez sur la zone localisée avec le talon de votre main", picture_url: "https://res.cloudinary.com/dqohqi3zr/image/upload/v1765460546/4-hand_rdvjba.png")

puts "Step 5"
Step.create!(step_type: "instruction", number: 5, case: case_rcp, details: "Joignez vos mains comme ceci :", picture_url: "https://res.cloudinary.com/dqohqi3zr/image/upload/v1765460546/5-hand-position_dvuw8h.png")

puts "Step 6"
Step.create!(step_type: "instruction", number: 6, case: case_rcp, details: "Réalisez les compressions thoraciques", picture_url: "https://res.cloudinary.com/dqohqi3zr/image/upload/v1765362475/rcp-video_nm4lsg.gif")

puts "Last Step infos"
Step.create!(step_type: "information", case: case_rcp, details: last_step_info)

puts "——— All Seeds created ———"
