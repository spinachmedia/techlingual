class CreateIgnoreWordMsts < ActiveRecord::Migration
  def change
    create_table :ignore_word_msts do |t|
      t.text :word

      t.timestamps null: false
    end
  end
end
