import 'dart:convert';

class User{
  String id;
  String firstName;
  String lastName;
  String email;
  String urlImage;

  User({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.urlImage = "",
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? urlImage,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'urlImage': urlImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      urlImage: map['urlImage'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, urlImage: $urlImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.urlImage == urlImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    email.hashCode ^
    urlImage.hashCode;
  }
}