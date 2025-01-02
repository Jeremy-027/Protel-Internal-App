import 'package:dio/dio.dart';
import '../models/user.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.17.130:5000/api',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<User> login(String username, String password) async {
    try {
      final response = await _dio.post('/users/login', data: {
        'username': username,
        'password': password,
      });

      final user = User.fromJson(response.data);

      if (user.role != UserRole.mekanik && user.role != UserRole.satpam) {
        throw Exception('Unauthorized: Access restricted to mechanics and security personnel');
      }

      return user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.receiveTimeout:
        return 'Server not responding';
      case DioExceptionType.badResponse:
        final message = e.response?.data?['message'];
        return message ?? 'Server error';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Connection failed';
    }
  }
}