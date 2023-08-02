import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String username;
  String email;

  User({required this.email, required this.id, required this.username});

   static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      id: snapshot['id'],
      username: snapshot['username'],
      email: snapshot['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
      };
}
