// lib/data/services/service_api.dart

import 'package:dio/dio.dart';
import '../models/service.dart';

class ServiceApi {
  final Dio _dio;

  ServiceApi(this._dio);

  Future<void> createService(Map<String, dynamic> serviceData) async {
    try {
      print('Creating ticket with data: $serviceData');
      // Convert kilometer to int before sending
      final formattedData = {
        'noPolisi': serviceData['noPolisi'],
        'kilometer': serviceData['kilometer'], // Already an int from TextField
        'tanggalMasuk': DateTime.now().toIso8601String(),
      };

      final response = await _dio.post('/tickets', data: formattedData);
      print('Ticket created: ${response.data}');
    } on DioException catch (e) {
      print('Error creating ticket: ${e.response?.data}');
      print('Attempted URL: ${e.requestOptions.uri}');
      throw 'Failed to create ticket: ${e.message}';
    }
  }


  Future<List<Service>> getServices() async {
    try {
      print('Attempting to connect to: ${_dio.options.baseUrl}/services');

      final response = await _dio.get('/tickets');
      print('Response received: ${response.data}');

      final List<dynamic> servicesJson = response.data['services'];
      return servicesJson.map((json) => Service.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching services: $e');
      throw 'Failed to load services: $e';
    }
  }

}