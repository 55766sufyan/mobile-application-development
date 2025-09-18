import 'dart:io';

void main() {
  stdout.write("Enter Range: ");
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print("Invalid input! Please enter a number.");
    return;
  }

  int? num = int.tryParse(input);
  if (num == null || num <= 0) {
    print("Please enter a positive number greater than zero.");
    return;
  }

  for (int i = 1; i <= num; i++) {
    for (int j = 1; j <= i; j++) {
      stdout.write("$j ");
    }
    print("");
  }
}
