require 'diary'

RSpec.describe Diary do
  describe '#all' do
    it 'initially has no entries' do
      diary = Diary.new
      expect(diary.all).to eq []
    end
  end

  describe '#count_words' do
    it 'initially has 0 words' do
      diary = Diary.new
      expect(diary.count_words).to eq 0
    end
  end

  describe '#reading_time' do
    it 'initially returns 0' do
      diary = Diary.new
      expect(diary.reading_time(50)).to eq 0
    end
  end

  describe '#find_best_entry_for_reading_time' do
    it 'initially returns no entry' do
      diary = Diary.new
      expect(diary.find_best_entry_for_reading_time(80, 6)).to eq nil
    end
  end
end