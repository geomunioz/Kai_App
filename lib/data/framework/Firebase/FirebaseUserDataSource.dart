import 'package:app_eat/data/datasources/UserDataSource.dart';
import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/framework/Firebase/FirebaseConstants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserDataSource extends UserDataSource{
  static const TAG = "FirebaseUserDataSource";
  FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<bool> addUser(User user) async {
    try {
      await _database
          .collection(COLLECTION_USERS)
          .doc(user.id)
          .set(user.toMap());

      return true;
    } catch (error) {
      print("$TAG:addUser:Error: $error");
      return false;
    }
  }

  @override
  Future<User?> getUser(String id) async {
    final response = await _database.collection(COLLECTION_USERS).doc(id).get();

    if (response.exists && response.data() != null) {
      return User.fromMap(response.data()!);
    } else {
      return null;
    }
  }

  @override
  Stream<User?> getUserListener(String id) async* {
    final snapshots =
    _database.collection(COLLECTION_USERS).doc(id).snapshots();

    await for (final snapshot in snapshots) {
      if (snapshot.exists && snapshot.data() != null) {
        yield User.fromMap(snapshot.data()!);
      }
    }
  }

  @override
  Future<bool> updateUser(String userId, Map<String, dynamic> changes) async{
    try {
      if (userId.isEmpty) {
        throw new Exception("user id must not be empty");
      }

      await _database.collection(COLLECTION_USERS).doc(userId).update(changes);

      return true;
    } catch (error) {
      print("$TAG:updateUser:Error: $error");
      return false;
    }
  }

  @override
  Future<bool> addProductToCar(String userId, Product product) async{
    try {
      await _database.collection(COLLECTION_USERS)
          .doc(userId)
          .collection(COLLECTION_CAR)
          .doc(product.id)
          .set(product.toMap());
      return true;
    } catch (error) {
      print("$TAG:addProduct:Error: $error");
      return false;
    }
  }

  @override
  Future<bool> addReservation(String reservationId, Product product) async{
    try {
      await _database.collection(COLLECTION_RESERVATION)
          .doc(reservationId)
          .collection(COLLECTION_CAR)
          .doc(product.id)
          .set(product.toMap());
      return true;
    } catch (error) {
      print("$TAG:addProduct:Error: $error");
      return false;
    }
  }

  @override
  Future<List<Product>> getProductsCar(String userId) async{
    try {
      final snapshots = await _database.collection(COLLECTION_USERS).doc(userId).collection(COLLECTION_CAR).get();
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

  @override
  Future<bool> removeProductToCar(String userId, String productId) async{
    try {
      await _database.collection(COLLECTION_USERS)
          .doc(userId)
          .collection(COLLECTION_CAR)
          .doc(productId)
          .delete();
      return true;
    } catch (error) {
      print("$TAG:addProduct:Error: $error");
      return false;
    }
  }

  @override
  Future<bool> removeCar(String userId) async{
    try {
      var snapshots = await _database.collection(COLLECTION_USERS)
          .doc(userId)
          .collection(COLLECTION_CAR)
          .get();

      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      return true;
    } catch (error) {
      print("$TAG:removeCar:Error: $error");
      return false;
    }
  }

  @override
  String? getReservation() {
    try {
      final _reference = _database.collection(COLLECTION_RESERVATION);
      final _reservationId = _reference.doc().id;

      return _reservationId.toString();

    } catch (error) {
      print("$TAG:getReservationId:Error: $error");
      return "";
    }
  }

}