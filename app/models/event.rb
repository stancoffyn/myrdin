class Event < ApplicationRecord
  validates :event_name, presence: true
  validates :scheduled_for, presence: true
  validates :created_by, presence: true
end
