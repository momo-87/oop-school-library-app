require_relative "../classroom.rb"
require_relative "../student.rb"

describe Classroom do
  let(:classroom) {Classroom.new}

  describe "#new" do
    it "returns a classroom object" do
      classroom.should be_an_instance_of Classroom
    end
  end

  describe "#label" do
    it "returns the correct default label" do
      classroom.label.should eql "Unknown"
    end
  end

  describe "#students" do
    it "returns students as an array" do
      classroom.students.should be_an_instance_of Array
    end
  end

  describe "#students is an empty array" do
    it "returns students as empty array" do
      expect(classroom.students).to be_empty 
    end
  end

  let(:student) {Student.new(18, nil, "Momo")}
  describe "Test add_student method" do
    it "returns classroom students as not empty array" do
      classroom.add_student(student)
      expect(classroom.students).not_to be_empty 
    end

    it "returns students array item as instance of Student" do
      classroom.add_student(student)
      classroom.students[0].should be_an_instance_of Student
    end
  end
end