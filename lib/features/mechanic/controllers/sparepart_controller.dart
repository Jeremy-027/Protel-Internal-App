// lib/features/mechanic/controllers/sparepart_controller.dart

import 'package:get/get.dart';
import '../../../data/models/sparepart.dart';
import '../../../data/services/sparepart_service.dart';

class SparepartController extends GetxController {
  final SparepartService _sparepartService = SparepartService();
  final RxBool isLoading = false.obs;
  final RxList<Sparepart> allSpareparts = <Sparepart>[].obs;
  final RxList<Sparepart> filteredSpareparts = <Sparepart>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpareparts();
  }

  Future<void> fetchSpareparts() async {
    try {
      isLoading.value = true;
      final spareparts = await _sparepartService.getAllSpareparts();
      allSpareparts.value = spareparts;
      filteredSpareparts.value = spareparts; // Show all initially
    } catch (e) {
      print('Error fetching spareparts: $e');
      Get.snackbar('Error', 'Failed to load spareparts');
    } finally {
      isLoading.value = false;
    }
  }

  void filterSpareparts(String query) {
    if (query.isEmpty) {
      filteredSpareparts.value = allSpareparts;
    } else {
      filteredSpareparts.value = allSpareparts.where((sparepart) =>
      sparepart.namaPart.toLowerCase().contains(query.toLowerCase()) ||
          sparepart.number.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
  }
}