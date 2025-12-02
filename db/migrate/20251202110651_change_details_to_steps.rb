class ChangeDetailsToSteps < ActiveRecord::Migration[7.1]
  def change
    change_column :steps, :details, :text
  end
end
