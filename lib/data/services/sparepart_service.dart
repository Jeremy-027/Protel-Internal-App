// lib/data/services/sparepart_service.dart
import 'api_config.dart';
import 'package:dio/dio.dart';
import '../models/sparepart.dart';

class SparepartService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<Sparepart>> getAllSpareparts() async {
    try {
      print('Fetching spareparts...');
      final response = await _dio.get('/spareparts');
      print('Response received: ${response.data}');

      if (response.data == null || !response.data.containsKey('spareparts')) {
        return [];
      }

      final List<dynamic> sparepartsJson = response.data['spareparts'];
      return sparepartsJson.map((json) => Sparepart.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching spareparts: $e');
      throw 'Failed to load spareparts: $e';
    }
  }
}