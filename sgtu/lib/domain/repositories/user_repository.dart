import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> updateProfile({
    required String id,
    required String nombre,
    required String apellido,
    required String correo,
    String? telefono,
    String? dni,
    String? password,
    String? imagen,
  });
}