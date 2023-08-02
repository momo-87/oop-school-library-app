require 'json'
require_relative '../person'

RSpec.describe Person do
  let(:person_name) { 'Tamara Dimov' }
  let(:person_age) { 32 }
  let(:parent_permission) { true }
  let(:person) { Person.new(person_age, person_name, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'creates a person with given id, name, age, parent permission, and an empty rentals array' do
      expect(person.id).to be_an(Integer)
      expect(person.name).to eq(person_name)
      expect(person.age).to eq(person_age)
      expect(person.instance_variable_get(:@parent_permission)).to eq(parent_permission)
      expect(person.rentals).to be_an(Array)
    end
  end
end
