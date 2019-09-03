class Strike < ApplicationRecord
  belongs_to :union
  belongs_to :category
  has_many :reminders
end
