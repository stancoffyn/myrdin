require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test 'should be able to create a character' do
    character = Character.new
    character.name = 'noodler'
    character.level = 53
    character.character_class_type = 4
    character.last_online = DateTime.now
    assert character.save
  end

  test 'should not be able to create a character without name and last online' do
    character = Character.new
    character.character_class_type = 11
    character.level = 48
    assert_not character.save
  end

  test 'should be able to create and update multiple characters at once.' do
    Character.create name: 'bhindu', level: 51,
                     last_online: DateTime.now, character_class_type: 4
    Character.create name: 'shafaron', level: 55,
                     last_online: DateTime.now, character_class_type: 11
  end
end
