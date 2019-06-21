class Apikey < ApplicationRecord
  enum auth_type: { core: 0, master: 1, looter: 2, raid_leader: 3, viewer: 4 }
  validates :token, presence: true
  validates :auth_type, presence: true

  def self.create_core_key
    sec_key = SecureRandom.hex(10)
    key = Apikey.new
    key.token = sec_key
    key.core!
    key.active = true
    return key.save, key
  end
end
