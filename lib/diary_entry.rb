class DiaryEntry

  attr_reader :title, :contents

  def initialize(title, contents)
    @title = title
    @contents = contents
    @furthest_word_read = 0
  end

  def count_words
    words.length
  end

  def reading_time(wpm)
    fail "The reading pace must be more than 0" if wpm < 1
    (count_words.to_f / wpm).ceil
  end

  def reading_chunk(wpm, minutes)
    fail "The reading pace must be more than 0" if wpm < 1
    words_we_can_read = wpm * minutes
    start_from = @furthest_word_read
    end_at = @furthest_word_read + words_we_can_read
    @furthest_word_read += end_at
    word_list = words[start_from, end_at]
    if end_at >= count_words
      @furthest_word_read = 0
    else
      @furthest_word_read = end_at
    end
    word_list.join(" ")
  end

  private 

  def words
    @contents.split
  end
end