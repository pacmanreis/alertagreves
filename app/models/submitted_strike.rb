class SubmittedStrike < ApplicationRecord
  belongs_to :union, optional: true
  belongs_to :category
  belongs_to :user
  accepts_nested_attributes_for :union
  validates :organization, :start_date, :end_date, presence: true
end
