// lib/data/services/service_api.dart

import 'package:dio/dio.dart';
import '../models/service.dart';
import 'api_config.dart';

class ServiceApi {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<void> createService(Map<String, dynamic> serviceData) async {
    try {
      print('Creating ticket with data: $serviceData');
      final formattedData = {
        'noPolisi': serviceData['noPolisi'],
        'kilometer': serviceData['kilometer'].toString(), // Convert to String
        'tanggalMasuk': DateTime.now().toIso8601String(),
      };

      final response = await _dio.post('/tickets', data: formattedData);
      print('Ticket created: ${response.data}');
    } on DioException catch (e) {
      print('Error creating ticket: ${e.response?.data}');
      print('Attempted URL: ${e.requestOptions.uri}');
      throw _handleDioError(e);
    }
  }

  Future<List<Service>> getServices() async {
    try {
      print('Fetching services...');
      final response = await _dio.get('/tickets');
      print('Response received: ${response.data}');

      if (!response.data.containsKey('services')) {
        throw 'Invalid response format';
      }

      final List<dynamic> servicesJson = response.data['services'];
      return servicesJson.map((json) => Service.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      print('Error fetching services: $e');
      throw 'Failed to load services: $e';
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.receiveTimeout:
        return 'Server not responding. Please try again.';
      case DioExceptionType.badResponse:
        final message = e.response?.data?['message'];
        return message ?? 'Server error: ${e.response?.statusCode}';
      default:
        return 'Connection failed. Please check your internet connection.';
    }
  }
}