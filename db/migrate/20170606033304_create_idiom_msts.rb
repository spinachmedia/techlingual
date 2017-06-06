class CreateIdiomMsts < ActiveRecord::Migration
  def change
    create_table :idiom_msts do |t|
      t.text :idiom
      t.text :mean

      t.timestamps null: false
    end
  end
end
