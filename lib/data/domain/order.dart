import 'dart:convert';

class Product{
  String id;
  int quantity;

  Product({
    this.id = "",
    this.quantity = 0,
  });

  Product copyWith({
    String? id,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? "",
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    quantity.hashCode;
  }

}