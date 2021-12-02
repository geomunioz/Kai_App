import 'package:app_eat/data/datasources/AuthDataSource.dart';
import 'package:app_eat/data/domain/ExternalUser.dart';

class AuthRepository {
  AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<ExternalUser?> signInWithGoogle() {
    return authDataSource.signInWithGoogle();
  }

  Future<bool> signOut() {
    return authDataSource.signOut();
  }

  String? getUserId() {
    return authDataSource.getUserId();
  }

  Future<String?> signInWithEmail(String email, String password) {
    return authDataSource.signInWithEmail(email, password);
  }

  Future<String?> signUpWithEmail(String email, String password) {
    return authDataSource.signUpWithEmail(email, password);
  }

  Future<bool> sendPasswordResetEmail(String email) {
    return authDataSource.sendPasswordResetEmail(email);
  }
}