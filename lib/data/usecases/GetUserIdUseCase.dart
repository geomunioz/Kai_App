import 'package:app_eat/data/repositories/AuthRepository.dart';

class GetUserIdUseCase {
  final AuthRepository authRepository;

  GetUserIdUseCase({required this.authRepository});

  String? invoke() {
    return authRepository.getUserId();
  }
}