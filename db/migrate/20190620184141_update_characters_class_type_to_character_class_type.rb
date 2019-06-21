class UpdateCharactersClassTypeToCharacterClassType < ActiveRecord::Migration[5.1]
  def change
    rename_column :characters, :class_type, :character_class_type
  end
end
