class Reminder < ApplicationRecord
  belongs_to :strike
  belongs_to :user
end
