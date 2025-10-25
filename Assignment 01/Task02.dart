import 'dart:io';
void main() {
  
  // --- Name ---
  stdout.write("Enter your name: ");
  String? name = stdin.readLineSync();
  if (name == null || name.trim().isEmpty) {
    print("Invalid name! Exiting...");
    return;
  }

  // --- Age ---
  stdout.write("Enter your age: ");
  String? ageInput = stdin.readLineSync();
  int? age = int.tryParse(ageInput ?? "");
  if (age == null || age <= 0) {
    print("Invalid age! Exiting...");
    return;
  }
  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return;
  }

  // --- How many numbers ---
  stdout.write("How many numbers you want to add? ");
  String? countInput = stdin.readLineSync();
  int? n = int.tryParse(countInput ?? "");
  if (n == null || n <= 0) {
    print("Invalid count! Please enter a positive number.");
    return;
  }

  List<int> numbers = [];

  for (int i = 0; i < n; i++) {
    stdout.write("Enter ${i + 1} Number: ");
    String? numInput = stdin.readLineSync();
    int? x = int.tryParse(numInput ?? "");
    if (x == null) {
      print("Invalid number! Exiting...");
      return;
    }
    numbers.add(x);
  }

  // --- Calculations ---
  int evenSum = 0;
  int oddSum = 0;
  int largest = numbers[0];
  int smallest = numbers[0];

  for (int val in numbers) {
    if (val % 2 == 0) {
      evenSum += val;
    } else {
      oddSum += val;
    }

    if (val > largest) largest = val;
    if (val < smallest) smallest = val;
  }

  // --- Results ---
  print("\nResults:");
  print("Even Sum: $evenSum");
  print("Odd Sum: $oddSum");
  print("Largest Num: $largest");
  print("Smallest Num: $smallest");
}
