class CreateApikeys < ActiveRecord::Migration[5.1]
  def change
    create_table :apikeys do |t|
      t.string :token
      t.integer :auth_type
      t.boolean :active

      t.timestamps
    end
    add_index :apikeys, :auth_type
  end
end
