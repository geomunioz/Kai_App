import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class RemoveProductToCarUseCase {
  final UserRepository userRepository;

  RemoveProductToCarUseCase({required this.userRepository});

  Future<bool> invoke(String userId, String producId) {
    return userRepository.removeProductToCar(userId, producId);
  }
}