class User < ApplicationRecord
    has_many :created_events, inverse_of: 'creator', foreign_key: 'creator_id', class_name: "Event"
    has_and_belongs_to_many :attended_events, inverse_of: 'attendants', foreign_key: 'attendant_id', class_name: "Event"
    before_save   :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d]+\.[a-z]+\z/i.freeze

  validates :name, presence: true

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  #has_secure_password
  #validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
