import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/repositories/UserRepository.dart';

class AddReservationUseCase {
  UserRepository userRepository;

  AddReservationUseCase({required this.userRepository});

  Future<bool> invoke(String reservationId, Product product) {
    return userRepository.addReservation(reservationId, product);
  }
}