class ContentsDetailController < ApplicationController
  def index
    siteId = params[:id]
    
    # サイトデータ返却
    @site = UrlMst.find(siteId)
    
    # 単語一覧返却
    @words = WordRankInfo.getWordRankingTop100WithSiteID(siteId)
    
  end
end
