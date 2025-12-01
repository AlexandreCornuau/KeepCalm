class Case < ApplicationRecord
  has_many :interventions, :steps
end
