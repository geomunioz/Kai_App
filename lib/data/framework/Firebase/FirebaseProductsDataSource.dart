import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:app_eat/data/datasources/ProductsDataSource.dart';
import 'package:app_eat/data/domain/product.dart';

import 'FirebaseConstants.dart';

class FirebaseProductsDataSource extends ProductsDataSource {
  static const TAG = "FirebaseProductsDataSource";

  FirebaseFirestore _database = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<bool> addProduct(Product product) async {
    try {
      final _reference = _database.collection(COLLECTION_PRODUCTS);
      final _productId = _reference.doc().id;

      product.id = _productId;

      await _reference.doc(_productId).set(product.toMap());

      return true;
    } catch (error) {
      print("$TAG:addProduct:Error: $error");
      return false;
    }
  }

  @override
  Future<String> uploadFile(File _image) async {
    String url = _image.path.split('/').last;
    var storageReference = FirebaseStorage.instance.ref().child('images/${url}');
    var uploadTask = storageReference.putFile(_image);
    print(uploadTask);
    print('File Uploaded');
    String returnURL = await storageReference.getDownloadURL();
    return returnURL;
  }

  @override
  Future<Product?> getProduct(String productId) async{
    try {
      final response =
          await _database.collection(COLLECTION_PRODUCTS).doc(productId).get();

      if (response.exists && response.data() != null) {
        return Product.fromMap(response.data()!);
      } else {
        return null;
      }
    } catch (error) {
      print("$TAG:getProduct:Error: $error");
      return null;
    }
  }

  @override
  Future<List<Product>> getProducts() async{
    try {
      final snapshots = await _database.collection(COLLECTION_PRODUCTS).get();
      List<Product> products = [];

      snapshots.docs.forEach((document) {
        final product = Product.fromMap(document.data());
        products.add(product);
      });

      return products;
    } catch (error) {
      print("$TAG:getProducts:Error: $error");
      return [];
    }
  }
}
