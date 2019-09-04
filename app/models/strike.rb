class Strike < ApplicationRecord
  belongs_to :union
  belongs_to :category
  has_many :reminders
  accepts_nested_attributes_for :union

  validates :organization, :start_date, :end_date, presence: true
end
