namespace :replace_dictionary do
  desc "辞書の再登録"
  task :execute => :environment do
    
    puts DictionaryMst.count
    
    puts "辞書データを削除します。"
    
    # データの削除
    DictionaryMst.delete_all
    
    puts DictionaryMst.count
    
    count = 0
    
    DictionaryMst.transaction do
    
      # ファイルの読み込み
      begin
        File.open('./lib/ejdic-hand-utf8.txt') do |file|
          file.each_line do |record|
            #puts labmen
            replaced = record.gsub(/^(\w)\s+/,'\1<,,,>')
            data = replaced.split("<,,,>")
            DictionaryMst.new(:word => data[0],:mean =>data[1]).save
            
             count = count + 1
            if count % 500 == 0
              puts count
            end
            
          end
        end
        
       
      rescue SystemCallError => e
        puts "error"
      rescue IOError => e
        puts "error"
      end # begin
    end # transaction
    
    puts DictionaryMst.count
    
  end
end
