require "./person.rb"
require "./base_decorator.rb"
require "./capitalize_decorator.rb"
require "./nameable.rb"

p person = Person.new(36, "momo")
p person.correct_name
p cap = CapitalizeDecorator.new(person)
p cap.correct_name