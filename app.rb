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
    @rentals = []

    load_data_from_files
  end

  def list_all_books
    stored_books = []
    File.foreach('books.json') do |line|
      next if line.strip.empty?

      book = JSON.parse(line)
      puts "[Title: #{book['title']}, Author: #{book['author']}"
      stored_books << book
    end
    stored_books
  end

  def list_all_people
    stored_people = []
    File.foreach('people.json') do |line|
      next if line.strip.empty?

      person = JSON.parse(line)
      puts "[#{person['class']}] Name: #{person['name']}, ID: #{person['ID']}, Age: #{person['age']}"
      stored_people << person
    end
    stored_people
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
      person_hash = { class: person.class, name: person.name, ID: person.object_id, age: person.age }
      File.write('people.json', "#{JSON.generate(person_hash)}\n", mode: 'a')
    elsif num == '2'
      print 'specialization: '
      ans = gets.chomp
      person = Teacher.new(age, ans, name)
      @people << person
      person_hash = { class: person.class, name: person.name, ID: person.object_id, age: person.age }
      File.write('people.json', "#{JSON.generate(person_hash)}\n", mode: 'a')
    end
  end

  def create_a_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    book_hash = { title: book.title, author: book.author }
    File.write('books.json', "#{JSON.generate(book_hash)}\n", mode: 'a')
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
    @rentals << rental
    save_rentals_to_file
    rental
  end

  def list_all_rentals_for_a_person
    print 'ID of person: '
    ans = gets.chomp.to_i
    target_person = @people.find { |person| person.object_id == ans }
    if target_person.nil?
      puts 'Rentals: '
    else
      rentals = @rentals.select { |rental| rental.person.object_id == ans }
      puts 'Rentals: '
      rentals.each { |rental| puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" }
    end
  end

  private

  def load_data_from_files
    File.foreach('people.json') do |line|
      next if line.strip.empty?

      person = JSON.parse(line)
      if person['class'] == 'Student'
        student = Student.new(person['age'], nil, person['name'])
        student.parent_permission = false if person['parent_permission'] == false
        @people << student
      elsif person['class'] == 'Teacher'
        teacher = Teacher.new(person['age'], person['specialization'], person['name'])
        @people << teacher
      end
    end

    File.foreach('books.json') do |line|
      next if line.strip.empty?

      book = JSON.parse(line)
      @books << Book.new(book['title'], book['author'])
    end

    File.foreach('rentals.json') do |line|
      next if line.strip.empty?

      rental = Rental.from_json(line)
      @rentals << rental
    end
  end

  def save_rentals_to_file
    File.open('rentals.json', 'w') do |file|
      @rentals.each do |rental|
        file.puts rental.to_json
      end
    end
  end
end

class Rental
  attr_reader :person, :book
  attr_accessor :date

  def initialize(date = 'Undefined')
    @date = date
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

  def person=(person)
    @person = person
    person.rentals << self unless person.rentals.include?(self)
  end

  def book=(book)
    @book = book
    book.rentals << self unless book.rentals.include?(self)
  end
end
