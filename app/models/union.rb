class Union < ApplicationRecord
  has_many :strikes
  has_many :submitted_strikes

  validates :initials, presence: true
  validates :name, :initials, uniqueness: { case_sensitive: false }
end
