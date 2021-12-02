import 'package:app_eat/data/repositories/AuthRepository.dart';

class SignInWithEmailUseCase {
  final AuthRepository authRepository;

  SignInWithEmailUseCase({required this.authRepository});

  Future<String?> invoke(String email, String password) {
    return authRepository.signInWithEmail(email, password);
  }
}