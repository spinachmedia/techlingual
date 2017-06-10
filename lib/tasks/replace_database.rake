namespace :replace_database do
  desc "データを全部直す"
  task :execute => :environment do
    # Rake::Task["crawl_word"].invoke("execute")
    # Rake::Task["marge_count"].invoke("execute")
    # Rake::Task["set_means_for_word"].invoke("execute")
    Rake::Task.new('crawl_word:execute', Rake.application).invoke
    Rake::Task.new('marge_count:execute', Rake.application).invoke
    Rake::Task.new('set_means_for_word:execute', Rake.application).invoke
  end
end
