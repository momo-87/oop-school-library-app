require 'json'
require_relative '../person'
require_relative '../rental'

RSpec.describe Person do
  let(:person_name) { 'Tamara Dimov' }
  let(:person_age) { 32 }
  let(:parent_permission) { true }
  let(:person) { Person.new(person_age, person_name, parent_permission: true) }

  describe '#initialize' do
    it 'creates a person with given id, name, age, parent permission, and an empty rentals array' do
      expect(person.id).to be_an(Integer)
      expect(person.name).to eq(person_name)
      expect(person.age).to eq(person_age)
      expect(person.instance_variable_get(:@parent_permission)).to eq(parent_permission)
      expect(person.rentals).to be_an(Array)
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      let(:person_age) { 21 }

      it 'returns true' do
        expect(person.can_use_services?).to be true
      end
    end

    context 'when the person is under age but has parent permission' do
      let(:person_age) { 17 }

      it 'returns true' do
        expect(person.can_use_services?).to be true
      end
    end
  end

  describe '#correct_name' do
    it 'returns the correct name of the person' do
      expect(person.correct_name).to eq(person_name)
    end
  end
end
