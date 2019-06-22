# frozen_string_literal: true

# character active record object from database
class Character < ApplicationRecord
  validates :name, presence: true
  validates :last_online, presence: true
  has_many :events

  enum character_class_type: { offline: 0, warrior: 1, paladin: 2, hunter: 3,
                               rogue: 4, priest: 5, death_knight: 6,
                               shaman: 7, mage: 8,  warlock: 9, monk: 10,
                               druid: 11, demon_hunter: 12 }

  Factory.define :character do |c|
    c.name { Faker::Name.unique.name }
    c.level { rand(1..60) }
    c.character_class_type { rand(0..12) }
    c.last_online { DateTime.now }
  end
end
