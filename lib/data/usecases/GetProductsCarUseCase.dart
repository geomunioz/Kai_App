
import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class GetProductsCarUseCase {
  final UserRepository userRepository;

  GetProductsCarUseCase({required this.userRepository});

  Future<List<Product>> invoke(String userId) {
    return userRepository.getProductsCar(userId);
  }
}