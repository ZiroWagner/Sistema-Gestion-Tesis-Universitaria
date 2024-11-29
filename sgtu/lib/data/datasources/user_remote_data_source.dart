import 'package:dio/dio.dart';
import '../../core/api/dio_client.dart';
import '../../core/utils/constants.dart';

abstract class UserRemoteDataSource {
  Future<void> updateProfile({
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

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> updateProfile({
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
      final formData = FormData.fromMap({
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        if (telefono != null) 'telefono': telefono,
        if (imagen != null) 'image': await MultipartFile.fromFile(imagen),
      });

      final response = await dioClient.put(
        '${ApiConstants.updateUser}/$id',
        data: formData,
      );

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Error actualizando el perfil',
        );
      }
    } on TimeoutException catch (e) {
      print('Error de timeout: $e');
      rethrow;
    } catch (e) {
      print('Error en UserRemoteDataSource: $e');
      rethrow;
    }
  }
}