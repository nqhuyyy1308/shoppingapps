import 'dart:convert';

class Product{
  String id;
  String name;
  int price;
  String description;
  String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() =>{
    'id': id,
    'name': name,
    'price': price,
    'description': description,
    'image': image,
  };

  static Product fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    description: json['description'],
    image: json['image'],
  );
}
