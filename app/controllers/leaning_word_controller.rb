class LeaningWordController < ApplicationController
  def index
    
    site = UrlMst.find(params[:id])
    
    @result = Hash.new
    @result[:id] = site.id
    @result[:url] = site.url
    @result[:name] = site.name
    @result[:wordRank5] = WordRankInfo.getWordRankingTop5WithSiteID(site.id)
  
  end
  
  def getWord 
  end
  
  def getImages
    url = "https://pixabay.com/api/?"
    searchWord = params["searchWord"]
    res = nil
    client = HTTPClient.new
    query = {'key' => ENV["PIXABOY_APIKEY"], 'q' => searchWord}
    
    res = client.get(url, :query => query, :follow_redirect => true)

    # puts "code=#{res.code}"    # res.code : Fixnum
    # puts HTTP::Status.successful?(res.code)
    # p res.headers
    # puts res.body
    
    render :json => res.body
  end
  
  
end
