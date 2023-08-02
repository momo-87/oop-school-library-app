require 'json'
require_relative '../person'
require_relative '../student'

RSpec.describe Student do
  let(:student_name) { 'Tamara Dimov' }
  let(:student_age) { 32 }
  let(:classroom) { double('Classroom') }

  let(:student) { Student.new(student_age, classroom, student_name) }

  describe '#initialize' do
    it 'creates a student with given age, classroom, and name' do
      expect(student.name).to eq(student_name)
      expect(student.age).to eq(student_age)
      expect(student.instance_variable_get(:@parent_permission)).to eq(true)
      expect(student.classroom).to eq(classroom)
    end
  end

  describe '#play_hooky' do
    it "returns the string '¯(ツ)/¯'" do
      expect(student.play_hooky).to eq('¯(ツ)/¯')
    end
  end

  describe '#classroom=' do
    let(:students) { [] }

    before do
      allow(classroom).to receive(:students).and_return(students) # Fix the method name
      allow(students).to receive(:push) # Use the 'students' array to mock the 'push' method
    end

    context 'when the student is already in the classroom' do
      it 'does not add the student to the classroom again' do
        students << student
        student.classroom = classroom
        expect(students.count(student)).to eq(1)
      end
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the student' do
      json_data = student.to_json
      parsed_json = JSON.parse(json_data)
      expect(parsed_json['class']).to eq(student.class.to_s)
      expect(parsed_json['id']).to eq(student.instance_variable_get(:@id))
      expect(parsed_json['name']).to eq(student_name)
      expect(parsed_json['age']).to eq(student_age)
      expect(parsed_json['parent_permission']).to eq(student.instance_variable_get(:@parent_permission))
      expect(parsed_json['rentals']).to eq(student.instance_variable_get(:@rentals))
      expect(parsed_json.key?('classroom')).to be true
    end
  end
end
