import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/datasources/UserDataSource.dart';

class UserRepository{
  UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<User?> getUser(String id) {
    return userDataSource.getUser(id);
  }

  Future<bool> addUser(User user) {
    return userDataSource.addUser(user);
  }

  Future<bool> addProductToCar(String userId, Product product){
    return userDataSource.addProductToCar(userId, product);
  }

  Stream<User?> getUserListener(String id) {
    return userDataSource.getUserListener(id);
  }

  Future<bool> removeProductToCar(String userId, String productId){
    return userDataSource.removeProductToCar(userId, productId);
  }

  Future<bool> removeCar(String userId){
    return userDataSource.removeCar(userId);
  }

  Future<bool> updateUser(String userId, Map<String, dynamic> changes) {
    return userDataSource.updateUser(userId, changes);
  }

  Future<List<Product>> getProductsCar(String userId){
    return userDataSource.getProductsCar(userId);
  }

  String? getReservation(){
    return userDataSource.getReservation();
  }

  Future<bool> addReservation(String reservationId, Product product){
    return userDataSource.addReservation(reservationId, product);
  }

}