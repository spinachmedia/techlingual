class WordRankInfo < ActiveRecord::Base
  
  
  def self.getWordRankingTop5WithSiteID(siteId)
    
    # 無視単語リストを取得
    ignoreWordList = IgnoreWordMst.getArray
    
    puts(ignoreWordList)
    
    datas = WordRankInfo.where(url_mst_id: siteId).order("count desc")
    
    # 無視単語リストのデータを除外する
    datas.each_with_index do |data,i|

      if ignoreWordList.include?(data.word)
        datas.delete(data)
      else
      end
    end
    
    return datas.slice(0,10)
    
  end
  
  def self.getWordRankingTop100WithSiteID(siteId)
      # 無視単語リストを取得
    ignoreWordList = IgnoreWordMst.getArray
    
    puts(ignoreWordList)
    
    datas = WordRankInfo.where(url_mst_id: siteId).order("count desc")
    
    # 無視単語リストのデータを除外する
    datas.each_with_index do |data,i|

      if ignoreWordList.include?(data.word)
        datas.delete(data)
      else
      end
    end
    
    return datas.slice(0,100)
    
  end
  
end
