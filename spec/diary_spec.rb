require 'diary'

RSpec.describe Diary do
  it 'constructs the class' do
    diary = Diary.new
    expect(Diary).to respond_to(:new)
  end

  describe '#all' do
    context 'when we have not added any entry' do
      it 'shows an empty list' do
        diary = Diary.new
        expect(diary.all).to eq []
      end
    end
  end

  describe '#count_words' do
    context 'when we have not added any entry' do
      it 'returns 0' do
        diary = Diary.new
        expect(diary.count_words).to eq 0
      end
    end
  end

  describe '#reading_time' do
    context 'when wpm is 0' do
      it 'returns 0' do
        diary = Diary.new
        expect { diary.reading_time(0) }.to raise_error 'The reading pace must be more than 0'
      end
    end

    context 'when we have not added any entry' do
      it 'returns 0' do
        diary = Diary.new
        expect(diary.reading_time(4)).to eq 0
      end
    end
  end

  describe '#find_best_entry_for_reading_time' do
    context 'when we have not added an entry' do
      it 'returns 0' do
        diary = Diary.new
        expect(diary.find_best_entry_for_reading_time(3, 5)).to eq nil
      end
    end
  end
end