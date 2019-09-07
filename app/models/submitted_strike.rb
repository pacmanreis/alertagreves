class SubmittedStrike < ApplicationRecord
  belongs_to :union
  belongs_to :category
  belongs_to :user
end
