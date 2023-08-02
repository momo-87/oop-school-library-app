def rental_book(book, rental)
  rental.book = if book.instance_of?(Book)
                  book
                else
                  Book.new(book['title'], book['author'])
                end
end

def rental_person(person, rental)
  rental.person = if person.instance_of?(Teacher) || person.instance_of?(Student)
                    person
                  elsif person['class'] == 'Student'
                    Student.new(person['age'], nil, person['name'])
                  else
                    Teacher.new(person['age'], person['specialization'], person['name'])
                  end
end

def selected_rental_for_a_person(rentals, id)
  selected_rentals = []
  rentals.each do |rental|
    selected_rentals << rental if rental.instance_of?(Hash) && rental['person_id'] == id
    selected_rentals << rental if rental.instance_of?(Rental) && rental.person.id == id
  end
  selected_rentals
end
