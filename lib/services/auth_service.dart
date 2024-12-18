import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStreamChangesListner);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  User? get user {
    return _user;
  }

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> SignUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        _user = credential.user;
        return true;
      }
    } catch (e) {
      log(e.toString());
      print(e);
    }
    return false;
  }

  Future<bool> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void authStreamChangesListner(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }
}
