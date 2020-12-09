import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationResources {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChange => _firebaseAuth.onAuthStateChanged;

  Future<int> signUpWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      AuthResult authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch(e) {
      print("Platform Exception: Authentication: " + e.toString());
      return -1;
    } catch(e) {
      print("Exception: Authentication: " + e.toString());
      return -2;
    }
  }

  Future<int> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return 1;
    } on PlatformException catch(e) {
      print("Platform Exception: Authentication: " + e.toString());
      return -1;
    } catch(e) {
      print("Exception: Authentication: " + e.toString());
      return -2;
    }
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
  }

  Future<void> setUserDisplayName(FirebaseUser user, String displayName) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = displayName;
    await user.updateProfile(updateInfo);
  }
}