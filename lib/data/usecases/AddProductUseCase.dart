import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/ProductsRepository.dart';

class AddProductUseCase {
  final ProductsRepository productsRepository;

  AddProductUseCase({required this.productsRepository});

  Future<bool> invoke(Product product) {
    return productsRepository.addProduct(product);
  }
}