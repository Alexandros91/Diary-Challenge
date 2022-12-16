require 'diary_entry'

RSpec.describe DiaryEntry do
  describe '#initialize' do
    it 'constructs' do
      diary_entry = DiaryEntry.new('title', 'contents')
      expect(diary_entry.title).to eq 'title'
      expect(diary_entry.contents).to eq 'contents'
    end
  end

  describe 'count_words' do
    it 'counts the words in the entry\'s contents' do
      diary_entry = DiaryEntry.new('title', 'These are the contents')
      expect(diary_entry.count_words).to eq 4
    end
  end

  describe '#reading_time' do
    context 'when the reading pace is an invalid number' do
      it 'fails' do
        diary_entry = DiaryEntry.new('title 1', 'contents 1')
        expect { diary_entry.reading_time(0) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'when the reading pace is a valid number' do
      it 'returns the time needed to read all contents' do
        diary_entry = DiaryEntry.new('title 1', 'contents ' * 200)
        expect(diary_entry.reading_time(90)).to eq 3
      end
    end
  end

  describe '#reading_chunk' do
    context 'when the reading pace is an invalid number' do
      it 'fails' do
        diary_entry = DiaryEntry.new('title 1', 'contents 1')
        expect { diary_entry.reading_chunk(0, 5) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'when the reading pace is a valid number' do
      it 'returns the time needed to read all contents' do
        diary_entry = DiaryEntry.new('title 1', 'There are the contents of one more entry in the diary')
        diary_entry.reading_chunk(2, 2)
        diary_entry.reading_chunk(1, 3)
        expect(diary_entry.reading_chunk(2, 2)).to eq 'entry in the diary'
      end
    end
  end

end