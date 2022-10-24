class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String profilePicUrl;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicUrl,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "profilePicUrl": profilePicUrl,
    };
  }

  User fromFireStore(firestore) {
    return User(
      id: firestore["id"],
      firstName: firestore["firstName"],
      lastName: firestore["lastName"],
      email: firestore["email"],
      profilePicUrl: firestore["profilePicUrl"],
    );
  }
}
