class Event < ApplicationRecord
  belongs_to :creator, inverse_of: :created_events, class_name: 'User'
  has_many :events_users, foreign_key: :attended_event_id
  has_many :attendees, through: :events_users, inverse_of: 'attended_events', source: :attendee
  scope :upcoming, -> { where('date >= ?', Time.now) }
  scope :past, -> { where('date < ?', Time.now) }

  VALID_DATE_REGEX = /[0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}/i.freeze

  validates :date, presence: true, format: { with: VALID_DATE_REGEX }
  validates :location, presence: true
end
