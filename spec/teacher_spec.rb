require 'json'
require_relative '../person'
require_relative '../teacher'

RSpec.describe Teacher do
  let(:teacher_name) { 'Tamara' }
  let(:teacher_age) { 55 }
  let(:specialization) { 'Math' }

  let(:teacher) { Teacher.new(teacher_age, specialization, teacher_name) }

  describe '#initialize' do
    it 'creates a teacher with given age, name and specialization' do
      expect(teacher.name).to eq(teacher_name)
      expect(teacher.age).to eq(teacher_age)
      expect(teacher.specialization).to eq(specialization)
    end
  end
end
