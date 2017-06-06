class TopController < ApplicationController
  def index
    urls = UrlMst.all
    
    @results = []
    
    urls.each do |site|
    
      result = Hash.new
      result[:id] = site.id
      result[:url] = site.url
      result[:name] = site.name
      result[:wordRank5] = WordRankInfo.getWordRankingTop5WithSiteID(site.id)
      
      @results.push(result)
      
    end
    
  end
end
