// lib/data/services/auth_service.dart
import 'api_config.dart';
import 'package:dio/dio.dart';
import '../models/auth_response.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<AuthResponse> login(String username, String password) async {
    try {
      print('Attempting login with: $username'); // Debug print

      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      print('Response received: ${response.data}'); // Debug print

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Error details: ${e.response?.data}'); // Debug print
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      final message = e.response?.data?['message'];
      return message ?? 'Login failed';
    }
    return 'Connection failed. Please check your internet connection.';
  }
}