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
end
