require_relative '../classroom'
require_relative '../student'

RSpec.describe Classroom do
  let(:classroom) { described_class.new }
  let(:student) { Student.new(18, nil, 'Momo') }

  describe '#new' do
    it 'creates a classroom object' do
      expect(classroom).to be_an_instance_of(Classroom)
    end

    it 'assigns the default label' do
      expect(classroom.label).to eq('Unknown')
    end

    it 'initializes an empty students array' do
      expect(classroom.students).to be_an_instance_of(Array)
      expect(classroom.students).to be_empty
    end
  end

  describe '#label' do
    it 'returns the label' do
      classroom.label = 'Math'
      expect(classroom.label).to eq('Math')
    end
  end

  describe '#students' do
    it 'returns the students array' do
      expect(classroom.students).to be_an_instance_of(Array)
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      expect { classroom.add_student(student) }.to change { classroom.students.length }.by(1)
    end

    it 'associates the classroom with the added student' do
      classroom.add_student(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
