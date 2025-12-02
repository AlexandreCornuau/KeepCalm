class Intervention < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  has_one :chat
end
