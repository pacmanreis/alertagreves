class Sector < ApplicationRecord
  has_many :categories

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
