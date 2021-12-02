import 'dart:io';

import 'package:app_eat/data/domain/product.dart';

abstract class ProductsDataSource {
  Future<Product?> getProduct(String productId);
  Future<List<Product>> getProducts();
  Future<bool> addProduct(Product product);
  Future<String> uploadFile(File _image);
}