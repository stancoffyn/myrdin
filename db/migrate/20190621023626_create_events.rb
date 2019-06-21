class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.datetime :scheduled_for
      t.integer :created_by
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :completed

      t.timestamps
    end
  end
end
