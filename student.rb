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
end
