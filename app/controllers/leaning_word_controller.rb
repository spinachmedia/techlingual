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
    # ランダムで単語を返す。
    # 頻出単語のほうが、出現確率が高い。
    offset = params["number"]
    id = params["id"]
    result = WordRankInfo.where(url_mst_id: id).order("count desc").offset(offset).limit(1);
    render :json => result
  end
  
  def getImages
    url = "https://pixabay.com/api/?"
    searchWord = params["searchWord"]
    res = nil
    client = HTTPClient.new
    query = {
      'key' => ENV["PIXABOY_APIKEY"], 
      'q' => searchWord,
      'per_page' => 5, # 1ページ5件
      'page' => 1 # １ページ目の取得
    }
    res = client.get(url, :query => query, :follow_redirect => true)
    render :json => res.body
  end
  
end
