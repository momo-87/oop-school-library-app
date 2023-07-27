require "./app.rb"

class CreateNewApp
  @@app = App.new

  def main
    text = "Please choose an option by entering a number:
    1 - List all books
    2 - list all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - list all rentals for a given person id
    7 - exit"
    puts text
    option = gets.chomp
  
    if option == "7"
      puts "Exit successfully"
    end
    
    if option == "1"
      @@app.list_all_books
      puts " "
      main
    end

    if option == "2"
      @@app.list_all_people
      puts " "
      main
    end
  
    if option == "3"
      @@app.create_a_person
      puts "Person created successfully
      "
      main
    end
  
    if option == "4"
      @@app.create_a_book
      puts "Book created successfully
      "
      main
    end
  
  end
end

init = CreateNewApp.new
init.main