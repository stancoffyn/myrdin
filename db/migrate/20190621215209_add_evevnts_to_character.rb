class AddEvevntsToCharacter < ActiveRecord::Migration[5.1]
  def change
    add_reference :characters, :event, foreign_key: true
  end
end
