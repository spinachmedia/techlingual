class CreateWordInfos < ActiveRecord::Migration
  def change
    create_table :word_infos do |t|
      t.integer :url_mst_id
      t.text :word
      t.integer :count

      t.timestamps null: false
    end
  end
end
