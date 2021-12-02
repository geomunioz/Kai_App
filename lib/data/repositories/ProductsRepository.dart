import 'dart:io';

import 'package:app_eat/data/datasources/ProductsDataSource.dart';
import 'package:app_eat/data/domain/product.dart';

class ProductsRepository {
  ProductsDataSource productsDataSource;

  ProductsRepository({required this.productsDataSource});

  Future<Product?> getProduct(String productId) {
    return productsDataSource.getProduct(productId);
  }

  Future<List<Product>> getProducts() {
    return productsDataSource.getProducts();
  }

  Future<bool> addProduct(Product product) {
    return productsDataSource.addProduct(product);
  }

  Future<String> uploadFile(File _image){
    return productsDataSource.uploadFile(_image);
  }
}