require './student'
require './teacher'
require './book'
require './rental'
require 'date'

class App
  attr_reader :people

  def initialize
    @people = []
    @books = []
  end

  def list_all_books
    @books.select { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_all_people
    @people.select do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.object_id}, Age: #{person.age}"
    end
  end

  def create_a_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    num = gets.chomp

    print 'Age: '
    age = gets.chomp

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
    rental = Rental.new

    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, i| puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}" }
    rental.book = @books[gets.chomp.to_i]
    puts ' '

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, i|
      puts "#{i}) [#{person.class}]\
    Name: #{person.name},\
    ID: #{person.object_id},\
    Age: #{person.age}"
    end
    rental.person = @people[gets.chomp.to_i]
    puts ' '

    print 'Date: '
    rental.date = Date.parse(gets.chomp)
    rental
  end

  def list_all_rentals_for_a_person
    print 'ID of person: '
    ans = gets.chomp.to_i
    target_person = @people.filter { |person| person.object_id == ans }
    if target_person.empty?
      puts 'Rentals: '
    else
      rentals = target_person[0].rentals
      puts 'Rentals: '
      rentals.select { |rental| puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" }
    end
  end
end
