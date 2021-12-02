import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class GetUserListenerUseCase {
  final UserRepository userRepository;

  GetUserListenerUseCase({required this.userRepository});

  Stream<User?> invoke(String id) {
    return userRepository.getUserListener(id);
  }
}