require 'diary_entry'

RSpec.describe DiaryEntry do
  describe '#title, #contents' do
    it 'constructs' do
      diary_entry_1 = DiaryEntry.new("title_1", "contents_1")
      expect(diary_entry_1.title).to eq "title_1"
      expect(diary_entry_1.contents).to eq "contents_1"
    end
  end

  describe '#count_words' do
    context 'if the contents are empty' do
      it 'returns zero' do
        diary_entry_1 = DiaryEntry.new("title_1", "")
        expect(diary_entry_1.count_words).to eq 0
      end
    end

    context 'if the contents are not empty' do
      it 'returns the number of words in the contents' do
        diary_entry_1 = DiaryEntry.new("title_1", "my name is Alex")
        expect(diary_entry_1.count_words).to eq 4
      end
    end
  end

  describe '#reading_time' do
    context 'when the reading time is less than 1' do
      it 'fails' do
        diary_entry_1 = DiaryEntry.new("title_1", "contents_1 " * 500)
        diary_entry_1.count_words
        expect { diary_entry_1.reading_time(0) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'when the reading time is at least 1' do
      it 'returns an estimated reading time in minutes' do
        diary_entry_1 = DiaryEntry.new("title_1", "contents_1 " * 500)
        diary_entry_1.count_words
        expect(diary_entry_1.reading_time(120)).to eq 5
      end
    end

    describe '#reading_chunk' do
      context 'when the wpm is 0' do
        it 'fails' do
          diary_entry_1 = DiaryEntry.new("title_1", "one two")
          expect { diary_entry_1.reading_chunk(0, 10) }.to raise_error "The reading pace must be more than 0"
        end
      end

      context 'when the whole text is readable the first time' do
        it 'returns the whole text' do
          diary_entry_1 = DiaryEntry.new("title_1", "one two three")
          expect(diary_entry_1.reading_chunk(2, 2)).to eq "one two three"
        end
      end

      context 'when the whole text is not readable the first time' do
        it 'returns the readable chunk' do
          diary_entry_1 = DiaryEntry.new("title_1", "one two three")
          expect(diary_entry_1.reading_chunk(2, 1)).to eq "one two"
        end
      end

      context 'when the whole next is readable the second time' do
        it 'returns the second readable chunk, skipping the first' do
          diary_entry_1 = DiaryEntry.new("title_1", "one two three four")
          diary_entry_1.reading_chunk(2, 1)
          expect(diary_entry_1.reading_chunk(2, 1)).to eq "three four"
        end
      end
      
      context 'when it is called more than 2 times and is not yet fully read' do
        it 'restarts from the beginning' do
          diary_entry_1 = DiaryEntry.new("title_1", "one two three four five six")          
          diary_entry_1.reading_chunk(2, 2)
          diary_entry_1.reading_chunk(2, 1)
          expect(diary_entry_1.reading_chunk(2, 2)).to eq "one two three four"
        end
      end
    end
  end

  



end