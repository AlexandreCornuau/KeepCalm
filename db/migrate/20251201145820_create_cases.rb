class CreateCases < ActiveRecord::Migration[7.1]
  def change
    create_table :cases do |t|
      t.string :name
      t.string :gif_url

      t.timestamps
    end
  end
end
