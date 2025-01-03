// lib/data/services/sparepart_service.dart

import 'package:dio/dio.dart';
import '../models/sparepart.dart';

class SparepartService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.17.130:5000/api',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<Sparepart>> searchSpareparts(String query) async {
    try {
      final response = await _dio.get('/spareparts', queryParameters: {
        'search': query,
      });

      final List<dynamic> sparepartsJson = response.data['spareparts'];
      return sparepartsJson.map((json) => Sparepart.fromJson(json)).toList();
    } catch (e) {
      print('Error searching spareparts: $e');
      throw 'Failed to search spareparts';
    }
  }
}