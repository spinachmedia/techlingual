class MergeCount
    
    def self.execute
        
        WordRankInfo.delete_all
        
        # 集計結果をマージする
        # WordMst => WordRankInfo
        # WordMstは、URLごとのランキング
        # WordRankInfoは、コンテンツごとのランキングとする
        margeWordRank
        
    end
    
    def self.margeWordRank
       
        #サイトの一覧を取得
        sites = UrlMst.all
        sites.each do |site|
            
            #結果を格納するハッシュ
            words = WordInfo.where(url_mst_id: site.id).group(:word).sum(:count)
            words.each do |k,v|
                w = WordRankInfo.new
                w.word = k
                w.count = v
                w.url_mst_id = site.id
                w.save
            end
       end
    end #def
    
end

namespace :marge_count do
  desc "データのマージ"
  task :execute => :environment do
    MergeCount.execute
  end
end