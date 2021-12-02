import 'package:app_eat/data/datasources/AuthDataSource.dart';
import 'package:app_eat/data/domain/ExternalUser.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDataSource implements AuthDataSource{
  static const TAG = "FirebaseAuthDataSource";

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  String? getUserId() {
    final _user = _firebaseAuth.currentUser;
    return _user == null ? null : _user.uid;
  }

  @override
  Future<ExternalUser?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        throw ("googleSignInAccount is null");
      }

      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      UserCredential authResult =
      await _firebaseAuth.signInWithCredential(credential);

      final _user = authResult.user;

      if (_user == null || _user.isAnonymous) {
        throw ("_user is null or anonymous");
      }

      final user = _firebaseAuth.currentUser;

      if (user == null || user.uid != _user.uid) {
        throw ("user is null or uid are diferent");
      }

      return ExternalUser(
          uid: user.uid,
          displayName: _user.displayName,
          email: _user.email,
          phoneNumber: _user.phoneNumber,
          photoURL: _user.photoURL);
    } catch (error) {
      print("$TAG:signInWithGoogle:Error: $error");
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    }

    return true;
  }

  @override
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = userCredential.user;

      return user == null ? null : user.uid;
    } catch (error) {
      print("$TAG:signInWithEmail:Error: $error");
      return null;
    }
  }

  @override
  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = userCredential.user;

      return user == null ? null : user.uid;
    } catch (error) {
      print("$TAG:signUpWithEmail:Error: $error");
      return null;
    }
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      print("$TAG:sendPasswordResetEmail:Error: $error");
      return false;
    }
  }

}