class Step < ApplicationRecord
  belongs_to :case
  TYPE = ["information", "instruction"]
  validates :type, presence: true, inclusion: { in: Step::TYPE }
  validates :case_id, presence: true
end
