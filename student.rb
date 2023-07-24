require './person'

class Student < Person
  def initialize(classroom)
    super(age, 'Unknown', true)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
