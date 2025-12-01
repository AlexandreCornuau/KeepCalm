class Case < ApplicationRecord
  has_many :interventions
  has_many :steps
end
