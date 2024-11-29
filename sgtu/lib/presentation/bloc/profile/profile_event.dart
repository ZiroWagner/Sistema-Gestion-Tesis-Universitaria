import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileRequested extends ProfileEvent {
  final String id;
  final String nombre;
  final String apellido;
  final String correo;
  final String? telefono;
  final String? dni;
  final String? password;
  final String? imagen;

  const UpdateProfileRequested({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    this.telefono,
    this.dni,
    this.password,
    this.imagen,
  });

  @override
  List<Object?> get props => [id, nombre, apellido, correo, telefono, dni, password, imagen];
}