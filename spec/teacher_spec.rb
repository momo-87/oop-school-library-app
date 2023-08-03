require 'json'
require_relative '../person'
require_relative '../teacher'

RSpec.describe Teacher do
  let(:teacher_name) { 'Tamara' }
  let(:teacher_age) { 55 }
  let(:specialization) { 'Mathematics' }

  let(:teacher) { Teacher.new(teacher_age, specialization, teacher_name) }

  describe '#initialize' do
    it 'creates a teacher with given age, name, and specialization' do
      expect(teacher.name).to eq(teacher_name)
      expect(teacher.age).to eq(teacher_age)
      expect(teacher.specialization).to eq(specialization)
    end
  end

  describe '#can_use_services?' do
    it 'returns true for teachers' do
      expect(teacher.can_use_services?).to be true
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the teacher' do
      json_data = teacher.to_json
      parsed_json = JSON.parse(json_data)

      expect(parsed_json['class']).to eq('Teacher') # Change 'teacher.class.to_s' to 'Teacher'
      expect(parsed_json['name']).to eq(teacher_name)
      expect(parsed_json['age']).to eq(teacher_age)
      expect(parsed_json['specialization']).to eq(specialization)
    end
  end
end
