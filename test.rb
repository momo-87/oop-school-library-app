require "./classroom.rb"
require "./student.rb"

momo = Student.new(36, "L1", "Momo")
room = Classroom.new("L1")
room.add_student(momo)
# p momo.classroom
p room.students


christian = Student.new(20, "M1", "Christian")
christian.classroom = room
# p christian.classroom
p room.students