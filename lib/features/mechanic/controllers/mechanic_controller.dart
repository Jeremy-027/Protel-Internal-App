// lib/features/mechanic/controllers/mechanic_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/pkb.dart';
import '../../../data/services/pkb_service.dart';
// lib/features/mechanic/controllers/mechanic_controller.dart

class MechanicController extends GetxController {
  final PKBService _pkbService = PKBService();
  final RxBool isLoading = false.obs;
  final RxList<PKB> pkbs = <PKB>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPKBs();
  }

  Future<void> fetchPKBs() async {
    try {
      print('MechanicController: Starting PKB fetch');
      isLoading.value = true;
      final fetchedPkbs = await _pkbService.getPKBs();
      print('MechanicController: Received ${fetchedPkbs.length} PKBs');
      pkbs.value = fetchedPkbs;
    } catch (e) {
      print('MechanicController error: $e');
      Get.snackbar(
        'Error',
        'Failed to load PKBs: $e',
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePKBLayanan(String pkbId, List<String> layananIds) async {
    try {
      await _pkbService.updatePKBLayanan(pkbId, layananIds);
      await fetchPKBs(); // Refresh the list after update
      Get.snackbar(
        'Success',
        'Layanan berhasil diperbarui',
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memperbarui layanan',
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      throw e;
    }
  }

  Future<void> updatePKBResponse(String pkbId, String response) async {
    try {
      await _pkbService.updateMechanicResponse(pkbId, response);
      await fetchPKBs(); // Refresh the list after update
    } catch (e) {
      print('Error updating PKB response: $e');
      throw e;
    }
  }
}