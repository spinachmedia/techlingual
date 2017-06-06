class CreateDictionaryMsts < ActiveRecord::Migration
  def change
    create_table :dictionary_msts do |t|
      t.text :word
      t.text :mean

      t.timestamps null: false
    end
  end
end
