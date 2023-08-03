require 'json'
require_relative '../book'

RSpec.describe Book do
  let(:book_title) { 'The Great Gatsby' }
  let(:book_author) { 'F. Scott Fitzgerald' }
  let(:book) { Book.new(book_title, book_author) }

  describe '#initialize' do
    it 'creates a book with the correct title and author' do
      expect(book.title).to eq(book_title)
      expect(book.author).to eq(book_author)
      expect(book.rentals).to be_an(Array)
    end
  end

  describe '#add_rental' do
    it 'adds a rental to the book and sets the book for the rental' do
      rental = instance_double('Rental')
      expect(rental).to receive(:book=).with(book)
      book.add_rental(rental)
      expect(book.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the book' do
      json_data = book.to_json
      parsed_json = JSON.parse(json_data)
      expect(parsed_json['title']).to eq(book_title)
      expect(parsed_json['author']).to eq(book_author)
      expect(parsed_json['rentals']).to eq(book.instance_variable_get(:@rentals))
    end
  end
end
