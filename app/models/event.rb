class Event < ApplicationRecord
  belongs_to :creator
  has_and_belongs_to_many :attendants

  VALID_DATE_REGEX = /[0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}/i.freeze

  validates :date, presence: true, format: { with: VALID_DATE_REGEX }
  validates :location, presence: true
end
