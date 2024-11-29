import 'package:dio/dio.dart';
import '../../core/api/dio_client.dart';
import '../../core/utils/constants.dart';
import '../../presentation/bloc/app_state/app_state_bloc.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dioClient.post(
        ApiConstants.login,
        data: {
          'correo': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('user') &&
            responseData.containsKey('token')) {
          final userData = responseData['user'] as Map<String, dynamic>;
          final token = responseData['token'] as String;
          dioClient.appStateBloc.add(UpdateToken(token));
          userData['token'] = responseData['token'] as String;
          return UserModel.fromJson(userData);
        } else {
          throw FormatException('Unexpected server response format');
        }
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: ApiConstants.login),
          response: response,
        );
      }
    } on TimeoutException catch (e) {
      print('Error de timeout: $e');
      rethrow;
    } catch (e) {
      print('Error en login: $e');
      rethrow;
    }
  }
}