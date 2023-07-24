require './person'

class Teacher < Person
  def initialize(specialization)
    super(age, 'Unknown', true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
