import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../../core/error/failures.dart';

class UpdateProfileUseCase {
  final UserRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateProfileParams params) async{
    return await repository.updateProfile(
      id: params.id,
      nombre: params.nombre,
      apellido: params.apellido,
      correo: params.correo,
      telefono: params.telefono,
      dni: params.dni,
      password: params.password,
      imagen: params.imagen,
    );
  }
}

class UpdateProfileParams {
  final String id;
  final String nombre;
  final String apellido;
  final String correo;
  final String? telefono;
  final String? dni;
  final String? password;
  final String? imagen;

  UpdateProfileParams({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    this.telefono,
    this.dni,
    this.password,
    this.imagen,
  });
}

