import 'dart:io';

class User {
  String email;

  String name;

  String userID;

  String profilePictureURL;

  String appIdentifier;

  User(
      {this.email = '',
        this.name = '',
        this.userID = '',
        this.profilePictureURL = ''})
      : appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';

  String fullName() => name;

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        name: parsedJson['name'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'id': userID,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': appIdentifier
    };
  }
}