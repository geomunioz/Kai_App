import 'package:app_eat/data/repositories/UserRepository.dart';

class GetReservationUseCase {
  final UserRepository userRepository;

  GetReservationUseCase({required this.userRepository});

  String? invoke() {
    return userRepository.getReservation();
  }
}