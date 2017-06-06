class CreateWordRankInfos < ActiveRecord::Migration
  def change
    create_table :word_rank_infos do |t|
      t.text :word
      t.integer :count
      t.integer :url_mst_id

      t.timestamps null: false
    end
  end
end
