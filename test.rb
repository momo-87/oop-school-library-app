require "./classroom.rb"
require "./student.rb"
require "./book.rb"

# momo = Student.new(36, "L1", "Momo")
# room = Classroom.new("L1")
# room.add_student(momo)
# # p momo.classroom
# p room.students


# christian = Student.new(20, "M1", "Christian")
# christian.classroom = room
# # p christian.classroom
# p room.students

book = Book.new("Hello", "Momo")

p book
p book.title
book.title = "Ho"
p book.title