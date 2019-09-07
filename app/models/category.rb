class Category < ApplicationRecord
  has_many :strikes
  has_many :submitted_strikes
  belongs_to :sector

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
