require_relative '../rental.rb'
require 'json'

RSpec.describe Rental do
  let(:person) { double(id: 1, rentals: []) }
  let(:book) { double(title: 'Book Title', author: 'Book Author', rentals: []) }
  let(:rental) { Rental.new('2023-08-03') }

  before do
    rental.person = person
    rental.book = book
  end

  describe '#initialize' do
    it 'sets the date' do
      expect(rental.date).to eq('2023-08-03')
    end
  end

  describe '#person=' do
    it 'sets the person and adds the rental to the person' do
      expect(rental.person).to eq(person)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#book=' do
    it 'sets the book and adds the rental to the book' do
      expect(rental.book).to eq(book)
      expect(book.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'returns the rental data in JSON format' do
      expected_json = {
        person_id: 1,
        book_title: 'Book Title',
        book_author: 'Book Author',
        date: '2023-08-03'
      }.to_json

      expect(rental.to_json).to eq(expected_json)
    end
  end
end