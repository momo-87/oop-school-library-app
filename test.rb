require "./classroom.rb"
require "./student.rb"
require "./book.rb"
require "./person.rb"
require "./rental.rb"

momo = Student.new(36, "L1", "Momo")
christian = Student.new(20, "M1", "Christian")

book_1 = Book.new("HI", "Mael")
book_2 = Book.new("HO", "Amiel")

rental_1 = Rental.new("2017-12-22")
rental_2 = Rental.new("2017-12-31")

rental_1.person = momo
rental_1.book = book_1

p book_2.rentals.count

book_2.add_rental(rental_1)
p book_2.rentals




# rental_3 = Rental.new(christian, book_2, "2017-11-11")
# rental_3 = Rental.new(christian, book_2, "2017-11-11")

# book_2.add_rental(christian, "2017-12-31")