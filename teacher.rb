require './person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(*args)
    {
      class: self.class,
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals,
      specialization: @specialization
    }.to_json(*args)
  end
end
