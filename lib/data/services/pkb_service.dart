import 'package:dio/dio.dart';
import '../models/pkb.dart';
import 'api_config.dart';

class PKBService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<PKB>> getPKBs() async {
    try {
      print('Starting PKB fetch...');
      final response = await _dio.get('/pkb');
      print('Raw response: ${response.data}');

      if (response.data == null || !response.data.containsKey('pkbs')) {
        print('Invalid response structure: ${response.data}');
        return [];
      }

      final pkbsJson = response.data['pkbs'] as List;
      return pkbsJson.map((json) => PKB.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching PKBs: $e');
      return []; // Return empty list instead of throwing
    }
  }

  Future<void> updatePKBLayanan(String pkbId, List<String> layananIds) async {
    try {
      await _dio.patch('/pkb/$pkbId', data: {
        'layanan': layananIds
      });
    } catch (e) {
      print('Error updating layanan: $e');
      throw 'Failed to update layanan';
    }
  }

  Future<void> updateMechanicResponse(String pkbId, String mechResponse) async {
    try {
      print('Updating PKB response...');
      print('PKB ID: $pkbId');
      print('New Response: $mechResponse');

      final dioResponse = await _dio.put(
          '/pkb/$pkbId',
          data: {
            'responsMekanik': mechResponse
          }
      );

      print('Update response: ${dioResponse.data}');
    } on DioException catch (e) {
      print('Error details: ${e.response?.data}');
      print('Attempted URL: ${e.requestOptions.uri}');
      print('Request data: ${e.requestOptions.data}');
      throw 'Failed to update response';
    }
  }
}