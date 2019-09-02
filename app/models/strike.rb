class Strike < ApplicationRecord
  belongs_to :syndicate
  belongs_to :category
  belongs_to :sector
  has_many :reminders
end
