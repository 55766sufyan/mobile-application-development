class MenuItemModel {
  String id;
  String name;
  double price;
  String imageUrl;
  String? imageBase64;
  String description;
  bool available;

  MenuItemModel({required this.id, required this.name, required this.price, required this.imageUrl, this.imageBase64, this.description = '', this.available = true});

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => MenuItemModel(
    id: json['_id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
    imageUrl: json['imageUrl'] ?? '',
    imageBase64: json['imageBase64'],
    description: json['description'] ?? '',
    available: json['available'] ?? true
  );
}
