import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/ProductsRepository.dart';

class GetProductsUseCase {
  final ProductsRepository productsRepository;

  GetProductsUseCase({required this.productsRepository});

  Future<List<Product>> invoke() {
    return productsRepository.getProducts();
  }
}