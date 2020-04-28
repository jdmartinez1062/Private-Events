class User < ApplicationRecord
  has_many :created_events, inverse_of: 'creator', foreign_key: :creator_id, class_name: 'Event'
  has_many :events_users, foreign_key: :attendee_id
  has_many :attended_events, through: :events_users, inverse_of: 'attendees', source: :attended_event
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d]+\.[a-z]+\z/i.freeze

  validates :name, presence: true

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def upcoming_events
    attended_events.upcoming
  end

  def previous_events
    attended_events.past
  end

  private

  def downcase_email
    email.downcase!
  end
end
