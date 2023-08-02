def display_create_rental_books(books)
  books.each_with_index do |book, i|
    puts "#{i}) Title: \"#{book['title']}\", Author: #{book['author']}" if book.instance_of?(Hash)
    puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}" if book.instance_of?(Book)
  end
end

def display_create_rental_persons(persons)
  persons.each_with_index do |person, i|
    if person.instance_of?(Student) || person.instance_of?(Teacher)
      puts "#{i}) [#{person.class}]\
      Name: #{person.name},\
      ID: #{person.id},\
      Age: #{person.age}"
    else
      puts "#{i}) [#{person['class']}]\
      Name: #{person['name']},\
      ID: #{person['id']},\
      Age: #{person['age']}"
    end
  end
end

def display_selected_rentals(selected_rentals)
  puts 'Rentals: '
  selected_rentals.select do |rental|
    puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" if rental.instance_of?(Rental)
    if rental.instance_of?(Hash)
      puts "Date: #{rental['date']}, Book \"#{rental['book_title']}\" by #{rental['book_author']}"
    end
  end
end
