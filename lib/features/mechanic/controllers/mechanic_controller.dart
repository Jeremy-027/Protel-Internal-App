// lib/features/mechanic/controllers/mechanic_controller.dart

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
      isLoading.value = true;
      pkbs.value = await _pkbService.getPKBs();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
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