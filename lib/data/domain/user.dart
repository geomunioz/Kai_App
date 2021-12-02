import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:app_eat/data/domain/product.dart';

class User{
  String id;
  String firstName;
  String lastName;
  String email;
  String urlImage;
  List<Product> shoppingCar;

  User({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.urlImage = "",
    required this.shoppingCar,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? urlImage,
    List<Product>? shoppingCar,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      urlImage: urlImage ?? this.urlImage,
      shoppingCar: shoppingCar ?? this.shoppingCar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'urlImage': urlImage,
      'shoppingCar': shoppingCar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      urlImage: map['urlImage'] ?? "",
      shoppingCar: map['shoppingCar'] != null ? List<Product>.from(map['shoppingCar']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, urlImage: $urlImage, shoppingCar: $shoppingCar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.urlImage == urlImage &&
        listEquals(other.shoppingCar, shoppingCar);
  }

  @override
  int get hashCode {
    return id.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    email.hashCode ^
    urlImage.hashCode ^
    shoppingCar.hashCode;
  }
}