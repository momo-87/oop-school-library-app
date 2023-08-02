require './student'
require './teacher'
require './book'
require './rental'
require './read_files_data'
require './display'
require './procedures'
require 'date'
require 'json'

class App
  attr_reader :people

  def initialize
    @people = []
    @books = []
    @rental = Rental.new
    @stored_people = read_people_json
    @stored_books = read_books_json
    @stored_rentals = read_rentals_json
  end

  def list_all_books
    available_books = @stored_books + @books
    available_books.select do |book|
      puts "Title: \"#{book['title']}\", Author: #{book['author']}" if book.instance_of?(Hash)
      puts "Title: \"#{book.title}\", Author: #{book.author}" if book.instance_of?(Book)
    end
  end

  def list_all_people
    available_people = @stored_people + @people
    available_people.select do |person|
      if person.instance_of?(Student) || person.instance_of?(Teacher)
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "[#{person['class']}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
      end
    end
  end

  def create_a_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    num = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    if num == '1'
      person = Student.new(age, nil, name)
      print 'Has parent permission? [Y/N]: '
      ans = gets.chomp
      person.parent_permission = false if ans == 'N'
      @people << person
    elsif num == '2'
      print 'specialization: '
      ans = gets.chomp
      person = Teacher.new(age, ans, name)
      @people << person
    end
  end

  def create_a_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
  end

  def create_a_rental
    puts 'Select a book from the following list by number'
    available_books = @stored_books + @books
    display_create_rental_books(available_books)

    selected_book = available_books[gets.chomp.to_i]

    rental_book(selected_book, @rental)
    puts ' '

    puts 'Select a person from the following list by number (not id)'
    available_people = @stored_people + @people
    display_create_rental_persons(available_people)
    selected_person = available_people[gets.chomp.to_i]

    rental_person(selected_person, @rental)
    puts ' '

    print 'Date: '
    @rental.date = Date.parse(gets.chomp)
    @stored_rentals << @rental
  end

  def list_all_rentals_for_a_person
    print 'ID of person: '
    ans = gets.chomp.to_i
    selected_rentals = selected_rental_for_a_person(@stored_rentals, ans)

    if selected_rentals.empty?
      puts 'Rentals: '
    else
      display_selected_rentals(selected_rentals)
    end
  end

  def preserve_data
    @stored_people += @people
    File.write('people.json', JSON.generate(@stored_people).to_s)

    @stored_books += @books
    File.write('books.json', JSON.generate(@stored_books).to_s)

    File.write('rentals.json', JSON.generate(@stored_rentals).to_s)
    puts 'Thank you for using this app!'
  end
end
