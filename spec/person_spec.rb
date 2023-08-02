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

  describe '#add_rental' do
    let(:rental) { double('Rental') }

    it 'adds the rental to the rentals array and sets the rental\'s person to self' do
      person.add_rental(rental)
      expect(person.rentals).to include(rental)
      expect(rental.person).to eq(person)
    end
  end
end
