// lib/data/services/layanan_service.dart

import 'package:dio/dio.dart';
import '../models/layanan.dart';

class LayananService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.17.130:5000/api',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // Get all layanan
  Future<List<Layanan>> getAllLayanan() async {
    try {
      final response = await _dio.get('/layanan');
      final List<dynamic> layananJson = response.data['layanan'];
      return layananJson.map((json) => Layanan.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching layanan: $e');
      throw 'Failed to load layanan';
    }
  }

  // Get single layanan by ID
  Future<Layanan> getLayananById(String id) async {
    try {
      final response = await _dio.get('/layanan/$id');
      return Layanan.fromJson(response.data['layanan']);
    } catch (e) {
      print('Error fetching layanan by ID: $e');
      throw 'Failed to load layanan details';
    }
  }

  // Create new layanan
  Future<Layanan> createLayanan(String namaLayanan, int harga) async {
    try {
      final response = await _dio.post('/layanan', data: {
        'namaLayanan': namaLayanan,
        'harga': harga,
      });
      return Layanan.fromJson(response.data['layanan']);
    } catch (e) {
      print('Error creating layanan: $e');
      throw 'Failed to create layanan';
    }
  }

  // Update layanan (full update)
  Future<Layanan> updateLayanan(String id, String namaLayanan, int harga) async {
    try {
      final response = await _dio.put('/layanan/$id', data: {
        'namaLayanan': namaLayanan,
        'harga': harga,
      });
      return Layanan.fromJson(response.data['layanan']);
    } catch (e) {
      print('Error updating layanan: $e');
      throw 'Failed to update layanan';
    }
  }

  // Partial update layanan
  Future<Layanan> partialUpdateLayanan(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _dio.patch('/layanan/$id', data: updates);
      return Layanan.fromJson(response.data['layanan']);
    } catch (e) {
      print('Error updating layanan: $e');
      throw 'Failed to update layanan';
    }
  }

  // Delete layanan
  Future<void> deleteLayanan(String id) async {
    try {
      await _dio.delete('/layanan/$id');
    } catch (e) {
      print('Error deleting layanan: $e');
      throw 'Failed to delete layanan';
    }
  }
}