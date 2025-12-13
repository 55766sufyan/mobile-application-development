class UserModel {
  String id;
  String name;
  String email;
  String? phone;
  bool isAdmin;

  UserModel({required this.id, required this.name, required this.email, this.phone, this.isAdmin=false});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isAdmin: json['isAdmin'] ?? false
    );
  }
}
