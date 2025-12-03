class CreateDaes < ActiveRecord::Migration[7.1]
  def change
    create_table :daes do |t|
      t.string :status
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
