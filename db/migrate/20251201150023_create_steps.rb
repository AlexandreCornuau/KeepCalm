class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.string :details
      t.string :picture_url
      t.references :case, null: false, foreign_key: true

      t.timestamps
    end
  end
end
