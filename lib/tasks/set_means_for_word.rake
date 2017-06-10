namespace :set_means_for_word do
  desc "単語の意味をテーブルに登録する"
  task :execute => :environment do
    # WordRankInfoのデータを一周する。
    # トランザクションは貼らない
    words = WordRankInfo.all
    words.each do |word|
      dic = DictionaryMst.where(:word=>word.word).first
      if dic 
        word.mean = dic.mean
        word.save
      end
    end
  end
end
