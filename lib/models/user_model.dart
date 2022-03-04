import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  User({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "username": username,
        "bio": bio,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
      };

  static User fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
      email: snap['email'],
      uid: snap['uid'],
      username: snap['username'],
      bio: snap['bio'],
      photoUrl: snap['photoUrl'],
      followers: snap['followers'],
      following: snap['following'],
    );
  }
}
