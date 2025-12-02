class AddTypeToSteps < ActiveRecord::Migration[7.1]
  def change
    add_column :steps, :type, :string
  end
end
