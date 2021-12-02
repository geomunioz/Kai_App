import 'package:app_eat/data/repositories/UserRepository.dart';

class UpdateUserUseCase {
  UserRepository userRepository;

  UpdateUserUseCase({required this.userRepository});

  Future<bool> invoke(String userId, Map<String, dynamic> changes) {
    return userRepository.updateUser(userId, changes);
  }
}