import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      print('Error en AuthRepositoryImpl: $e');
      if (e is TimeoutException) {
        return const Left(TimeoutFailure());
      } else if (e is FormatException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(ServerFailure());
      }
    }
  }
}