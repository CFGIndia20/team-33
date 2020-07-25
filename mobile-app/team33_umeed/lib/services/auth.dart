import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import './database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  // Future<FirebaseUser> get getUser => _auth.currentUser();

  AuthUser _authUserFromFirebaseUser(FirebaseUser user) {
    return user != null ? AuthUser(uId: user.uid) : null;
  }

  Future<AuthResult> createUser(String email, String password) async {
    print("akash");
    print(email);
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Stream<AuthUser> get authUser {
    return _auth.onAuthStateChanged.map(_authUserFromFirebaseUser);
  }

  Stream<User> currentUser(String uId) {
    return Database(uId: uId).getUser();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
