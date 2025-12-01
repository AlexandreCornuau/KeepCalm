class Intervention < ApplicationRecord
  belongs_to :user
  belongs_to :case
  has_one :chat
end
