
import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class AddUserUseCase {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<bool> invoke(User user) {
    return userRepository.addUser(user);
  }
}