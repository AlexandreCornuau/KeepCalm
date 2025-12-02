class ChangeColumnTypeToSteps < ActiveRecord::Migration[7.1]
  change_table :steps do |t|
    t.rename :type, :step_type
  end
end
