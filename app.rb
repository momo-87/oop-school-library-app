require './student'
require './teacher'
require './book'
require './rental'
require 'date'
require 'json'

class App
  attr_reader :people

  def initialize
    @people = []
    @books = []
    @rental = Rental.new
    if File.exist?("people.json") && !File.zero?("people.json")
      @stored_people = JSON.parse(File.read("people.json"))
    else
      @stored_people = []
    end
    if File.exist?("books.json") && !File.zero?("books.json")
      @stored_books = JSON.parse(File.read("books.json"))
    else
      @stored_books = []
    end

    if File.exist?("rentals.json") && !File.zero?("rentals.json")
      @stored_rentals = JSON.parse(File.read("rentals.json"))
    else
      @stored_rentals = []
    end

  end

  def list_all_books
    available_books = @stored_books + @books
    available_books.select do |book|
      puts "Title: \"#{book["title"]}\", Author: #{book["author"]}" if book.class == Hash
      puts "Title: \"#{book.title}\", Author: #{book.author}" if book.class == Book
    end
  end

  def list_all_people
    available_people = @stored_people + @people
    available_people.select do |person|
      if person.class == Student || person.class == Teacher
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "[#{person["class"]}] Name: #{person["name"]}, ID: #{person["id"]}, Age: #{person["age"]}"
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
    available_books.each_with_index do |book, i|
      puts "#{i}) Title: \"#{book["title"]}\", Author: #{book["author"]}" if book.class == Hash
      puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}" if book.class == Book
    end
    selected_book = available_books[gets.chomp.to_i]

    if selected_book.class == Book
      @rental.book = selected_book
    else 
      @rental.book = Book.new(selected_book["title"], selected_book["author"])
    end
    puts ' '

    puts 'Select a person from the following list by number (not id)'
    available_people = @stored_people + @people
    available_people.each_with_index do |person, i|
      if person.class == Student || person.class == Teacher
        puts "#{i}) [#{person.class}]\
        Name: #{person.name},\
        ID: #{person.id},\
        Age: #{person.age}"
      else
        puts "#{i}) [#{person["class"]}]\
        Name: #{person["name"]},\
        ID: #{person["id"]},\
        Age: #{person["age"]}"
      end
    end
    selected_person = available_people[gets.chomp.to_i]
    if selected_person.class == Teacher || selected_person.class == Student
      @rental.person = selected_person
    elsif selected_person["class"] == "Student"
      @rental.person = Student.new(selected_person["age"], nil, selected_person["name"])
    else
      @rental.person = Teacher.new(selected_person["age"], selected_person["specialization"], selected_person["name"])
    end
    puts ' '

    print 'Date: '
    @rental.date = Date.parse(gets.chomp)
    @stored_rentals << @rental
  end

  def list_all_rentals_for_a_person
    print 'ID of person: '
    ans = gets.chomp.to_i
    selected_rentals = []
     @stored_rentals.each do |rental|
      selected_rentals << rental if rental.class == Hash && rental["person_id"] == ans
      selected_rentals << rental if rental.class == Rental && rental.person.id == ans
    end

    if selected_rentals.empty?
      puts 'Rentals: '
    else
      puts 'Rentals: '
      selected_rentals.select do |rental| 
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" if rental.class == Rental
        puts "Date: #{rental["date"]}, Book \"#{rental["book_title"]}\" by #{rental["book_author"]}" if rental.class == Hash
      end
    end
  end

  def preserve_data
    @stored_people += @people
    File.write("people.json", "#{JSON.generate(@stored_people)}")

    @stored_books += @books
    File.write("books.json", "#{JSON.generate(@stored_books)}")

    File.write("rentals.json", "#{JSON.generate(@stored_rentals)}")
    puts 'Thank you for using this app!'
  end

end
