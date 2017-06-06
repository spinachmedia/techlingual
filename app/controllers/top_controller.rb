class TopController < ApplicationController
  def index
    @urls = UrlMst.all
    
    @results = []
    
    @urls.each do |site|
    
      result = Hash.new
      result[:id] = site.id
      result[:url] = site.url
      result[:name] = site.name
      
      
      wordRankData = WordRankInfo.where(url_mst_id: site.id).order("count desc").limit(5)
      puts "data"
      puts wordRankData
      puts "data"
      result[:wordRank5] = wordRankData
      
      @results.push(result)
      
    end
    
  end
end
