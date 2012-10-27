class CreateTranslations < ActiveRecord::Migration

  def change
    create_table :translations do |t|
      t.string  :locale, null: false, length: 6
      t.integer :translatable_id
      t.string  :translatable_type
      t.string  :attribute_name, null: false
      t.text    :value
    end
    add_index :translations, :locale
    add_index :translations, [:translatable_id, :translatable_type]
    add_index :translations, [:locale, :translatable_id, :translatable_type, :attribute_name], unique: true, name: 'translation_key'
  end

end # CreateTranslations