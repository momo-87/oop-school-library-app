require "./student.rb"
require "./teacher.rb"
require "./book.rb"
require 'date'

class App
  attr_reader :people

  def initialize
    @people = []
    @books = []
  end

  def list_all_books
    @books.select {|book| puts "Title: \"#{book.title}\", Author: #{book.author}"}
  end

  def list_all_people
    @people.select {|person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.object_id}, Age: #{person.age}"}
  end

  def create_a_person
    print "Do you want to create a student (1) or a teacher (2)? [Input the number]: "
    num = gets.chomp

    print "Age: "
    age= gets.chomp

    print "Name: "
    name = gets.chomp

    if num == "1"
      person = Student.new(age, nil, name)
      print "Has parent permission? [Y/N]: "
      ans = gets.chomp
      person.parent_permission = false if ans == "N"
      @people << person
    elsif num == "2"
      print "specialization: "
      ans = gets.chomp
      person = Teacher.new(age, ans, name)
      @people << person
    end
  end

  def create_a_book
    print "Title: "
    title = gets.chomp
    print "Author: "
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
  end

  def create_a_rental
    puts "Select a book from the following list by number"
    @books.select {|book| puts "#{@books.index(book)}) Title: \"#{book.title}\", Author: #{book.author}"}
    ans = gets.chomp.to_i
    selected_book = @books[ans]
    puts " "
    puts "Select a person from the following list by number (not id)"
    @people.select {|person| puts "#{@people.index(person)}) [#{person.class}] Name: #{person.name}, ID: #{person.object_id}, Age: #{person.age}"}
    ans = gets.chomp.to_i
    selected_person = @people[ans]
    puts " "
    print "Date: "
    str_date = gets.chomp
    date = Date.parse(str_date)
  end

  def list_all_rentals_for_a_person

  end

end

