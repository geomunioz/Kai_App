import 'package:app_eat/data/repositories/AuthRepository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  Future<bool> invoke() {
    return authRepository.signOut();
  }
}
