class AddNumberToSteps < ActiveRecord::Migration[7.1]
  def change
    add_column :steps, :number, :integer
  end
end
