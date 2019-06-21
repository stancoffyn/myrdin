# frozen_string_literal: true

# Player characters who have joined any raid.
class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :level
      t.datetime :last_online
      t.integer :class_type, default: 0
      t.timestamps
    end
  end
end
