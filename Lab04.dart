// lab04.dart
// University Lab 04: Object-Oriented Programming in Dart

// Base class: Person
class Person {
  String name;
  int age;

  // Constructor
  Person(this.name, this.age);

  // Setter
  void set setName(String newName) {
    name = newName;
  }

  void set setAge(int newAge) {
    age = newAge;
  }

  // Getter
  String get getName => name;
  int get getAge => age;

  // Function
  void displayInfo() {
    print("Name: $name, Age: $age");
  }
}

// Derived class: Student
class Student extends Person {
  String course;

  // Constructor
  Student(String name, int age, this.course) : super(name, age);

  // Setter
  void set setCourse(String newCourse) {
    course = newCourse;
  }

  // Getter
  String get getCourse => course;

  // Function override
  @override
  void displayInfo() {
    print("Name: $name, Age: $age, Course: $course");
  }
}

void main() {
  // Create a Person object
  Person person1 = Person("Ali", 20);
  person1.displayInfo();

  // Update using setter
  person1.setName = "Ahmed";
  person1.setAge = 21;
  print("Updated Person:");
  person1.displayInfo();

  // Create a Student object (inheritance)
  Student student1 = Student("Sara", 19, "Computer Science");
  student1.displayInfo();

  // Update student info
  student1.setCourse = "Information Technology";
  print("Updated Student:");
  student1.displayInfo();
}
