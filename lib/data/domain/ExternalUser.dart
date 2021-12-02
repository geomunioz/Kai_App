import 'dart:convert';

class ExternalUser {
  String uid = "";
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoURL;

  ExternalUser({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
  });

  ExternalUser copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
  }) {
    return ExternalUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
    };
  }

  factory ExternalUser.fromMap(Map<String, dynamic> map) {
    return ExternalUser(
      uid: map['uid'] ?? "",
      displayName: map['displayName'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      photoURL: map['photoURL'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ExternalUser.fromJson(String source) =>
      ExternalUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExternalUser(uid: $uid, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExternalUser &&
        other.uid == uid &&
        other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
    displayName.hashCode ^
    email.hashCode ^
    phoneNumber.hashCode ^
    photoURL.hashCode;
  }
}