require 'diary'
require 'diary_entry'

RSpec.describe 'integration' do
  describe '#add' do
    it 'adds an entry to the diary' do
      diary = Diary.new
      diary_entry = DiaryEntry.new('title', 'contents')
      expect { diary.add(diary_entry) }.not_to raise_error
    end
  end

  describe '#all' do
    it 'shows a list of entries' do
      diary = Diary.new
      diary_entry_1 = DiaryEntry.new('title 1', 'contents 1')
      diary_entry_2 = DiaryEntry.new('title 2', 'contents 2')
      diary.add(diary_entry_1)
      diary.add(diary_entry_2)
      expect(diary.all).to eq [diary_entry_1, diary_entry_2]
    end
  end

  describe '#count_words' do
    it 'returns the number of words in all entries\' contents' do
      diary = Diary.new
      diary_entry_1 = DiaryEntry.new('title 1', 'contents 1')
      diary_entry_2 = DiaryEntry.new('title 2', 'contents 2')
      diary.add(diary_entry_1)
      diary.add(diary_entry_2)
      expect(diary.count_words).to eq 4
    end
  end

  describe '#reading_time' do
    context 'when the reading pace is an invalid number' do
      it 'fails' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new('title 1', 'contents 1')
        diary.add(diary_entry_1)
        expect { diary.reading_time(0) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'when the reading pace is a valid number' do
      it 'returns the time needed to read all contents' do
        diary = Diary.new
        diary_entry_1 = DiaryEntry.new('title 1', 'contents ' * 200)
        diary_entry_2 = DiaryEntry.new('title 2', 'contents ' * 260)
        diary.add(diary_entry_1)
        diary.add(diary_entry_2)
        expect(diary.reading_time(90)).to eq 6
      end
    end
  end


end