require './person'

class Student < Person
  attr_accessor :parent_permission
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown')
    super(age, name, parent_permission: true)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students << self unless classroom.students.include?(self)
  end

  def to_json(*args)
    {
      class: self.class,
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals,
      classroom: @classroom
    }.to_json(*args)
  end
end
