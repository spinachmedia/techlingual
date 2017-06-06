class IgnoreWordMst < ActiveRecord::Base
  def self.getArray
    ignoreWordList = IgnoreWordMst.all
    ignoreWords = []
    ignoreWordList.each do |word|
      ignoreWords.push(word.word)
    end
    return ignoreWords
  end
end
