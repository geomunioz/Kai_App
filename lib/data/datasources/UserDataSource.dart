import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/domain/product.dart';

abstract class UserDataSource{
  Future<User?> getUser(String id);
  Stream<User?> getUserListener(String id);
  String? getReservation();
  Future<bool> addUser(User user);
  Future<bool> addProductToCar(String userId, Product product);
  Future<bool> addReservation(String reservationId, Product product);
  Future<bool> updateUser(String userId, Map<String, dynamic> changes);
  Future<List<Product>> getProductsCar(String userId);
  Future<bool> removeProductToCar(String userId, String productId);
  Future<bool> removeCar(String userId);

}