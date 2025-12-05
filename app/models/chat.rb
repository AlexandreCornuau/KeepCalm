class Chat < ApplicationRecord
  belongs_to :intervention
  has_many :messages, dependent: :destroy
end
