import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user_model.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    return model.User.fromJson(snapshot);
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String response = 'Something went wrong';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        UserCredential res = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
            email: email,
            uid: res.user!.uid,
            username: username,
            bio: bio,
            photoUrl: photoUrl,
            followers: [],
            following: []);
        firestore.collection('users').doc(res.user!.uid).set(user.toJson());
      }
      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    print(response);
    return response;
  }

  Future<String> signinUser(
      {required String email, required String password}) async {
    String res = 'Something went wrong';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  void signOut() {
    _auth.signOut();
  }
}
