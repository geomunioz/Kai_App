import 'dart:convert';

class Product{
  String id;
  String idUser;
  String name;
  String description;
  String category;
  String quality;
  int quantity;
  String urlImage;
  double price;

  Product({
    this.id = "",
    this.idUser = "",
    this.name = "",
    this.description = "",
    this.category = "",
    this.quality = "",
    this.quantity = 0,
    this.urlImage = "",
    this.price = 0.0,
  });

  Product copyWith({
    String? id,
    String? idUser,
    String? name,
    String? description,
    String? category,
    String? quality,
    int? quantity,
    String? urlImage,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      quality: quality ?? this.quality,
      quantity: quantity ?? this.quantity,
      urlImage: urlImage ?? this.urlImage,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'name': name,
      'description': description,
      'category': category,
      'quality': quality,
      'quantity': quantity,
      'urlImage': urlImage,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? "",
      idUser: map['idUser'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      category: map['category'] ?? "",
      quality: map['quality'] ?? "",
      quantity: map['quantity'] ?? 0,
      urlImage: map['urlImage'] ?? "",
      price: map['price'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, idUser: $idUser, name: $name, description: $description, category: $category, quality: $quality, quantity: $quantity, urlImage: $urlImage, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.idUser == idUser &&
        other.name == name &&
        other.description == description &&
        other.category == category &&
        other.quality == quality &&
        other.quantity == quantity &&
        other.urlImage == urlImage &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    idUser.hashCode ^
    name.hashCode ^
    description.hashCode ^
    category.hashCode ^
    quality.hashCode ^
    quantity.hashCode ^
    urlImage.hashCode ^
    price.hashCode;
  }
}