import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  Future<User?> invoke(String id) {
    return userRepository.getUser(id);
  }
}