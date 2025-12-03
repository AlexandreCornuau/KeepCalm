class ModifyDaes < ActiveRecord::Migration[7.1]
  def change
    remove_column :daes, :status, :string
    add_column :daes, :street, :string
    add_column :daes, :postcode, :string
    add_column :daes, :city, :string
  end
end
