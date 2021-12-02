import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/ProductsRepository.dart';

class GetProductUseCase {
  final ProductsRepository productsRepository;

  GetProductUseCase({required this.productsRepository});

  Future<Product?> invoke(String productId) {
    return productsRepository.getProduct(productId);
  }
}