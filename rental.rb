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

  def to_json(*args)
    {
      person_id: @person.id,
      book_title: @book.title,
      book_author: @book.author,
      date: @date
    }.to_json(*args)
  end
  
end
