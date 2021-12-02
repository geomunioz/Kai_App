import 'package:app_eat/data/repositories/UserRepository.dart';

class RemoveCarUseCase {
  final UserRepository userRepository;

  RemoveCarUseCase({required this.userRepository});

  Future<bool> invoke(String userId) {
    return userRepository.removeCar(userId);
  }
}