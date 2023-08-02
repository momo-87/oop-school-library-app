require 'json'
require_relative '../person'
require_relative '../student'

RSpec.describe Student do
  let(:student_name) { 'Tamara Dimov' }
  let(:student_age) { 32 }
  let(:classroom) { 'Math' }

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
end
