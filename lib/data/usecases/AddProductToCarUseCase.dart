import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class AddProductToCarUseCase {
  final UserRepository userRepository;

  AddProductToCarUseCase({required this.userRepository});

  Future<bool> invoke(String userId, Product product) {
    return userRepository.addProductToCar(userId, product);
  }
}