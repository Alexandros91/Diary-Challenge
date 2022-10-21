class Diary

  def initialize
    @entries = []
  end

  def add(entry) 
    @entries << entry
  end

  def all
    @entries
  end

  def count_words
    @entries.sum(&:count_words)
  end

  def reading_time(wpm)
    fail "The reading pace must be more than 0" if wpm < 1
    (count_words.to_f / wpm).ceil
  end

  def find_best_entry_for_reading_time(wpm, minutes)
    raise 'The reading pace must be more than 0' if wpm < 1
    readable_entries(wpm, minutes).max_by(&:count_words)
  end

  private

  def readable_entries(wpm, minutes)
    @entries.filter do |entry|
      entry.reading_time(wpm) <= minutes
    end
  end
end