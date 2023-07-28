require './app'

class Start
  def options
    [
      'List all books',
      'List all people',
      'Create a person',
      'Create a book',
      'Create a rental',
      'List all rentals for a given person id',
      'Exit'
    ]
  end

  def display_menu
    puts 'Please choose an option by entering a number:'
    options.each_with_index { |option, i| puts "#{i + 1} - #{option}" }
  end

  def call_options
    {
      '1' => -> { @app.list_all_books },
      '2' => -> { @app.list_all_people },
      '3' => lambda {
               @app.create_a_person
               puts "Person created successfully\n"
             },
      '4' => lambda {
               @app.create_a_book
               puts "Book created successfully\n"
             },
      '5' => lambda {
               @app.create_a_rental
               puts "Rental created successfully\n"
             },
      '6' => -> { @app.list_all_rentals_for_a_person },
      '7' => -> { puts 'Thank you for using this app!' }
    }
  end

  def main
    @app = App.new
    calls = call_options

    loop do
      display_menu
      choice = gets.chomp
      if calls[choice]
        calls[choice].call
        return if choice == '7'
      else
        puts 'Sorry, the provided option does not exist'
      end

      puts ' '
    end
  end
end

init = Start.new
init.main
