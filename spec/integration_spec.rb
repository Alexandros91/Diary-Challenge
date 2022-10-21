require 'diary_entry'
require 'diary'

RSpec.describe 'integration' do
  describe '#add' do
    it 'adds an entry in the diary' do
      diary = Diary.new
      diary_entry_1 = DiaryEntry.new("title_1", "contents_1")
      expect(diary.add(diary_entry_1)).to eq [diary_entry_1]
    end
  end

  describe '#all' do
    context 'when we have added entries' do
      it 'shows a list of entries in the diary' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("title_1", "contents_1")
        diary_entry_2 = DiaryEntry.new("title_2", "contents_2")
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect(diary.all).to eq [diary_entry_1, diary_entry_2]
      end
    end
  end

  describe '#count_words' do
    it 'shows the number of words in all diary entries' do
      diary = Diary.new
      diary_entry_1 = DiaryEntry.new("Another day in the park", "contents_1 " * 200)
      diary_entry_2 = DiaryEntry.new("My first day at school", "contents_2 " * 250)
      diary.add(diary_entry_1)
      diary.add(diary_entry_2)
      expect(diary.count_words).to eq 450
    end
  end

  describe '#reading_time' do
    context 'if the wom is zero' do
      it 'fails' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "contents_1 " * 200)
        diary.add(diary_entry_1)
        expect { diary.reading_time(0) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'if the wom is at least 1' do
      it 'returns an estimate of the reading time for all entries where each entry fits exactly' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "hello " * 200)
        diary_entry_2 = DiaryEntry.new("Another night in the park", "Hi " * 300)
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect(diary.reading_time(100)).to eq 5
      end

      it 'returns an estimate of the reading time for all entries where one entry fallss over a minute' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "hello " * 200)
        diary_entry_2 = DiaryEntry.new("Another night in the park", "Hi " * 301)
        diary.add(diary_entry_1)
        diary.add(diary_entry_2) 
        expect(diary.reading_time(100)).to eq 6
      end

      it 'returns an estimate of the reading time for all entries where one entry is less and the other is more' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "hello " * 267)
        diary_entry_2 = DiaryEntry.new("Another night in the park", "Hi " * 323)
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect(diary.reading_time(100)).to eq 6
      end
    end
  end

  describe '#find_best_entry_for_reading_time' do
    context 'when the wpm is 0' do
      it 'raises error' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "hello ")
        diary.add(diary_entry_1)
        expect {  diary.find_best_entry_for_reading_time(0, 4) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'when we have just one entry that is not readable in the time' do
      it 'returns nothing' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "hello " * 625)
        diary.add(diary_entry_1)
        result = diary.find_best_entry_for_reading_time(150, 4)
        expect(result).to eq nil
      end
    end

    context 'when we have just one entry that is readable in the time' do
      it 'returns this entry' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new("Another day in the park", "one two")
        diary.add(diary_entry_1)
        result = diary.find_best_entry_for_reading_time(2, 1)
        expect(result).to eq diary_entry_1
      end
    end

    context 'when we have multiple entries readable in the time' do
      it 'returns the entry closest to but not over the given time' do
        diary = Diary.new
        best_entry = DiaryEntry.new("title", "one two")
        diary.add(best_entry)
        diary.add(DiaryEntry.new("title", "one"))
        diary.add(DiaryEntry.new("title", "one two three"))
        diary.add(DiaryEntry.new("title", "one two three four"))
        result = diary.find_best_entry_for_reading_time(2, 1)
        expect(result).to eq best_entry
      end
    end

    context 'when we have multiple entries not readable in the time' do
      it 'returns the entry closest to but not over the given time' do
        diary = Diary.new
        diary.add(DiaryEntry.new("title", "one two three four five"))
        diary.add(DiaryEntry.new("title", "one two three"))
        diary.add(DiaryEntry.new("title", "one two three four five six"))
        diary.add(DiaryEntry.new("title", "one two three four"))
        result = diary.find_best_entry_for_reading_time(2, 1)
        expect(result).to eq nil
      end
    end
  end
end
      