class CrawlWord
    
    # 検索数を保持
    @@count = 0

    # 1サイトごとに、以下の件数までしかカウントしない
    @@maxCount = 500;

    #一度クロールしたURLを格納
    @@croled_url = []
    
    # メイン処理
    def self.execute
        
        # データの全削除
        WordInfo.delete_all
        
        #モデルからクロール対象を取り出す
        urls = UrlMst.all
        
        #各サイトで再帰的にクロール
        urls.each do |url|
            
            #検索数をリセット
            @@count = 0
            
            #データの削除
            
            targetUrl = url.url
            countWordWithUrl(url,targetUrl)
            
        end #each
        
    end
    
    # URLから英単語をクロールする
    def self.countWordWithUrl (siteData,targetUrl)
        
        
        
        crawl_url = targetUrl
        
        #クエリストリングを削除
        crawl_url.gsub!(/\?.+$/,"")
        
        #クロール済みのURLであればスキップ
        if @@croled_url.include?(crawl_url) 
            puts "クロール済みURLであるためスキップ :" + crawl_url
           return 
        end
        
        # 自分自身の配下のURL以外はスキップ
        if crawl_url.include?(siteData.url)
        else
            puts crawl_url
            puts "配下のURLではないためスキップ :" + crawl_url
           return 
        end
        
        
        # 配列に格納し、クロール済みにカウント
        @@croled_url.push(crawl_url)
        
        # URLからページ内の単語の配列を取得
        # [A,A,A,B,B,C,A,A,D,C,...]
        words = crawlUrl(crawl_url)
        
        # 配列をマージし、[単語,個数]のHashに変換
        # {A:10,B:30}
        wordHash = countArray(words)
        
        puts "delete before: " + WordInfo.count.to_s
        # いれる予定のURLのレコードを全て削除
        # WordInfos.where(url: crawl_url).destroy_all
        puts "delete after: " + WordInfo.count.to_s
        
        # ハッシュをテーブルに突っ込む
        insertHash(wordHash,crawl_url,siteData.id)
        
        # URLから有効なリンクを取得
        links = getLinks(crawl_url)
        
        #リンクを再帰的に処理
        links.each do |link|
            
            # 最大検索数を越えたら戻ってくる
            if @@count > @@maxCount 
                return
            end
            
            next_url = siteData.domain + link
            countWordWithUrl(siteData,next_url)
            
            @@count = @@count + 1
        end
        
    end
    
    def self.getLinks url
        
        puts "リンクを取得するURL: " + url
        uri = URI.parse(url)
        string = Net::HTTP.get(uri)
        #bodyの中身だけを抽出
        string.gsub!(/^.*<body.*?>(.+)<\/body>.*/ ,'\1')
        #aタグだけを抽出
        urls = string.scan(/href="\/(.*?)"/) 
        urls.flatten!
        result = []
        urls.each do |data|
            if data.match(/(ico|jpeg|jpg|png|gif|css|js|svg|pdf|zip|tar|gz|7z)$/i)
                next   
            end
            if data.match(/^http/i)
                next   
            end
            if data.match(/^#/i)
                next   
            end
            if data.match(/^\//i)
                next   
            end
            if data.match(/^java/i)
                next   
            end
            result.push data
        end
        #配列を返す
        return result
        
    end
    
    
    # URLから英単語を取得、その際、不要なデータを削除
    def self.crawlUrl(url) 
        puts "これからクロールする: " + url.to_s
        uri = URI.parse(url)
        
        # req = Net::HTTP::Get.new uri
        code = Net::HTTP.get_response(uri).code

        if code == "200" then
        else
            return []
        end
          
        string = Net::HTTP.get(uri)
        #bodyの中身だけを抽出
        string.gsub!(/^.*<body.*?>(.+)<\/body>.*/ ,'\1')
        #scriptを削除
        string.gsub!(/<script.*?>.+<\/script>.*/ ,' ')
        #コメントアウトを削除
        string.gsub!(/<!--.*?-->/ ,' ')
        #タグを削除
        string.gsub!(/<.+?>/ ,' ')
        #, . を削除
        string.gsub!(/[,.\*]/," ")
        #英語以外を削除
        string.gsub!(/[^a-zA-Z]/," ")
        #空白を削除
        string.gsub!(/\s+/," ")
        #1～2文字のデータを削除
        string.gsub!(/\s\S\s/," ")
        string.gsub!(/\s\S\S\s/," ")
        string.gsub!(/\s\w\s/," ")
        string.gsub!(/\s\w\w\s/," ")
        # puts string
        string.downcase!
        
        # 配列に変換
        words = string.split(" ")
        
        return words
    end
    
    #それぞれを調べる
    def self.countArray(words)
        hash = Hash.new
        words.each do |word|
            hash[word] = words.count(word)
        end
        return hash
    end
    
    def self.insertHash (hash,url,id)
        puts hash.count
        puts "クロール完了。インサートするデータ：" + hash.count.to_s
        
        WordInfo.transaction do
            # 全部DBに突っ込む
            hash.each do |key,val|
                   
                wordInfo = WordInfo.new
                wordInfo.word = key
                wordInfo.count = val
                wordInfo.url_mst_id = id
                #wordInfo.url = url
                wordInfo.save
            
            end #each
        end
        
        puts "レコード合計: " + WordInfo.count.to_s
    end
    
end

namespace :crawl_word do
  desc "データの取得"
  task :execute => :environment do
    CrawlWord.execute
  end
end