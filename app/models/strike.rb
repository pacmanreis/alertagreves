class Strike < ApplicationRecord
  belongs_to :union
  belongs_to :category
  has_many :reminders
  accepts_nested_attributes_for :union
end
