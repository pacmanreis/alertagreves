class Strike < ApplicationRecord
  belongs_to :union, optional: true
  belongs_to :category
  has_many :reminders
  accepts_nested_attributes_for :union

  validates :organization, :start_date, :end_date, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_country_organization_description_and_union_id,
    against: [:country, :organization, :description, :union_id],
    associated_against: {
      union: [:name, :initials],
      category: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }

  def user_has_reminders?(user)
    self.reminders.where(user: user).any?
  end

  # Simple_Calendar
  def start_time
    self.start_date
  end
end
