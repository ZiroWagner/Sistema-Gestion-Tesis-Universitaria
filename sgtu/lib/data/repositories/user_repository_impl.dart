import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> updateProfile({
    required String id,
    required String nombre,
    required String apellido,
    required String correo,
    String? telefono,
    String? dni,
    String? password,
    String? imagen,
  }) async {
    try {
      await remoteDataSource.updateProfile(
        id: id,
        nombre: nombre,
        apellido: apellido,
        correo: correo,
        telefono: telefono,
        dni: dni,
        password: password,
        imagen: imagen,
      );
      return const Right(null);
    } catch (e) {
      print('Error en UserRepositoryImpl: $e');
      if (e is FormatException) {
        return Left(ServerFailure(message: 'FormatException: ${e.message}'));
      } else {
        return const Left(ServerFailure());
      }
    }
  }
}