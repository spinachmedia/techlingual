class AddMeanToWordRankInfo < ActiveRecord::Migration
  def change
    add_column :word_rank_infos, :mean, :text
  end
end
