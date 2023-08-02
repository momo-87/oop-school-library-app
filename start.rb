require './app'

class Start
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
      '7' => -> { @app.preserve_data }
    }
  end

  def execute
    @app = App.new
    main = Main.new
    loop do
      main.display_menu
      calls = call_options
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
