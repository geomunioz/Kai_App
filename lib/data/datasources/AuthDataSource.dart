import 'package:app_eat/data/domain/ExternalUser.dart';

abstract class AuthDataSource {
  String? getUserId();
  Future<ExternalUser?> signInWithGoogle();
  Future<String?> signInWithEmail(String email, String password);
  Future<String?> signUpWithEmail(String email, String password);
  Future<bool> sendPasswordResetEmail(String email);
  Future<bool> signOut();
}