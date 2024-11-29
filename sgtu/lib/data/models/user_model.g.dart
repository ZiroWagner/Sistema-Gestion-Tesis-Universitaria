// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      correo: json['correo'] as String,
      rol: json['rol'] as String,
      imgRuta: json['imgRuta'] as String?,
      estado: json['estado'] as bool,
      telefono: json['telefono'] as String?,
      dni: json['dni'] as String,
      fechaNacimiento: DateTime.parse(json['fechaNacimiento'] as String),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'correo': instance.correo,
      'rol': instance.rol,
      'imgRuta': instance.imgRuta,
      'estado': instance.estado,
      'telefono': instance.telefono,
      'dni': instance.dni,
      'fechaNacimiento': instance.fechaNacimiento.toIso8601String(),
      'token': instance.token,
    };
