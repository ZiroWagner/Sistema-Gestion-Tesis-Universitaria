import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String nombre;
  final String apellido;
  final String correo;
  final String rol;
  final String? imgRuta;
  final bool estado;
  final String? telefono;
  final String dni;
  final DateTime fechaNacimiento;
  final String token;

  const User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.rol,
    this.imgRuta,
    required this.estado,
    this.telefono,
    required this.dni,
    required this.fechaNacimiento,
    required this.token,
  });

  @override
  List<Object?> get props => [
    id,
    nombre,
    apellido,
    correo,
    rol,
    imgRuta,
    estado,
    telefono,
    dni,
    fechaNacimiento,
    token,
  ];
}