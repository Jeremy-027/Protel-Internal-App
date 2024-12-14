// lib/data/services/service_api.dart

import 'package:dio/dio.dart';
import '../models/service.dart';

class ServiceApi {
  final Dio _dio;

  ServiceApi(this._dio);

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

  Future<void> createService(Map<String, dynamic> serviceData) async {
    try {
      print('Creating service with data: $serviceData');
      await _dio.post('/services', data: serviceData);
      print('Service created successfully');
    } catch (e) {
      print('Error creating service: $e');
      throw 'Failed to create service: $e';
    }
  }
}