// lib/features/mechanic/controllers/sparepart_controller.dart

import 'package:get/get.dart';
import '../../../data/models/sparepart.dart';
import '../../../data/services/sparepart_service.dart';

class SparepartController extends GetxController {
  final SparepartService _sparepartService = SparepartService();
  final RxBool isLoading = false.obs;
  final RxList<Sparepart> searchResults = <Sparepart>[].obs;

  Future<void> searchSpareparts(String query) async {
    try {
      isLoading.value = true;
      final results = await _sparepartService.searchSpareparts(query);
      searchResults.value = results;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchResults.clear();
  }
}