# frozen_string_literal: true

# character active record object from database
class Character < ApplicationRecord
  enum character_class_type: { offline: 0, warrior: 1, paladin: 2, hunter: 3,
                               rogue: 4, priest: 5, death_knight: 6,
                               shaman: 7, mage: 8,  warlock: 9, monk: 10,
                               druid: 11, demon_hunter: 12 }
end
