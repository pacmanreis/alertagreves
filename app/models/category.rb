class Category < ApplicationRecord
  has_many :strikes
  belongs_to :sector
end
