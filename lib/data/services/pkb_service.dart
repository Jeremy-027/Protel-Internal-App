// lib/data/services/pkb_service.dart
import 'api_config.dart';
import 'package:dio/dio.dart';
import '../models/pkb.dart';

class PKBService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<PKB>> getPKBs() async {
    try {
      final response = await _dio.get('/pkb');
      final List<dynamic> pkbsJson = response.data['pkbs'];
      return pkbsJson.map((json) => PKB.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching PKBs: $e');
      throw 'Failed to load PKBs';
    }
  }

  Future<void> updatePKBLayanan(String pkbId, List<String> layananIds) async {
    try {
      print('Updating PKB $pkbId with layanan: $layananIds');
      await _dio.patch('/pkb/$pkbId', data: {
        'layanan': layananIds
      });
      print('Layanan updated successfully');
    } catch (e) {
      print('Error updating layanan: $e');
      throw 'Failed to update layanan: $e';
    }
  }

  Future<void> updateMechanicResponse(String pkbId, String response) async {
    try {
      print('Updating PKB $pkbId with response: $response');
      await _dio.patch(
          '/pkb/$pkbId',
          data: {
            'responsMekanik': response
          }
      );
      print('Response updated successfully');
    } catch (e) {
      print('Error updating response: $e');
      throw 'Failed to update response: $e';
    }
  }
}