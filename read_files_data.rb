def read_people_json
  if File.exist?('people.json') && !File.empty?('people.json')
    JSON.parse(File.read('people.json'))
  else
    []
  end
end

def read_books_json
  if File.exist?('books.json') && !File.empty?('books.json')
    JSON.parse(File.read('books.json'))
  else
    []
  end
end

def read_rentals_json
  if File.exist?('rentals.json') && !File.empty?('rentals.json')
    JSON.parse(File.read('rentals.json'))
  else
    []
  end
end
