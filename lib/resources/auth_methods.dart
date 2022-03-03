import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser ({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file
  }) async {
    String response= 'Something went wrong';
    try {
      if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty){
        UserCredential res= await _auth.createUserWithEmailAndPassword(email: email, password: password);
        firestore.collection('users').doc(res.user!.uid).set({
          'email': email,
          'username': username,
          'bio': bio,
          'followers': [],
          'following': []
        });
      }
      response= 'success';
    } catch (e) {
      response= e.toString();
    }
    print(response);
    return response;
  }
}
