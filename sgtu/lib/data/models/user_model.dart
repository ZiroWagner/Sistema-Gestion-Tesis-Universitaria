import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(nullable: true)
class UserModel extends User {
  const UserModel({
    required int id,
    required String nombre,
    required String apellido,
    required String correo,
    required String rol,
    String? imgRuta,
    required bool estado,
    String? telefono,
    required String dni,
    required DateTime fechaNacimiento,
    required String token,
  }) : super(
    id: id,
    nombre: nombre,
    apellido: apellido,
    correo: correo,
    rol: rol,
    imgRuta: imgRuta,
    estado: estado,
    telefono: telefono,
    dni: dni,
    fechaNacimiento: fechaNacimiento,
    token: token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      correo: json['correo'] as String,
      rol: json['rol'] as String,
      imgRuta: json['img_ruta'] as String?,
      estado: json['estado'] as bool,
      telefono: json['telefono'] as String?,
      dni: json['dni'] as String,
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento'] as String),
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}