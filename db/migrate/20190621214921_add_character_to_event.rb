class AddCharacterToEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :character, foreign_key: true
  end
end
