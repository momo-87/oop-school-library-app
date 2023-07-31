require './start.rb'

class Main
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
end

init = Start.new
init.execute
