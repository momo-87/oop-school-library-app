class Rental
  attr_reader :person, :book
  attr_accessor :date

  def initialize(date = 'Undefined')
    @date = date
  end

  def person=(person)
    @person = person
    person.rentals << self unless person.rentals.include?(self)
  end

  def book=(book)
    @book = book
    book.rentals << self unless book.rentals.include?(self)
  end

  def to_json(*_args)
    { person_id: @person.object_id, book_title: @book.title, book_author: @book.author, date: @date.to_s }.to_json
  end

  def self.from_json(json)
    data = JSON.parse(json)
    rental = Rental.new(Date.parse(data['date']))
    rental.person = App.get_person_by_id(data['person_id'])
    rental.book = App.get_book_by_title_and_author(data['book_title'], data['book_author'])
    rental
  end
end
