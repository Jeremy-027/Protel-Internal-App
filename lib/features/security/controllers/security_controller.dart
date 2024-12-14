// lib/features/security/controllers/security_controller.dart

import 'package:get/get.dart';
import '../../../data/models/service.dart';
import '../../../data/services/service_api.dart';

class SecurityController extends GetxController {
  final ServiceApi _serviceApi;
  final RxBool isLoading = false.obs;
  final RxList<Service> services = <Service>[].obs;

  SecurityController(this._serviceApi);

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      isLoading.value = true;
      final fetchedServices = await _serviceApi.getServices();
      services.value = fetchedServices;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createService(String noPolisi, String kilometer, DateTime tanggalMasuk) async {
    try {
      isLoading.value = true;
      final serviceData = {
        'noPolisi': noPolisi,
        'kilometer': int.parse(kilometer),
        'tanggalMasuk': tanggalMasuk.toIso8601String(),
      };
      await _serviceApi.createService(serviceData);
      await fetchServices();
      Get.snackbar('Success', 'Service entry created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
