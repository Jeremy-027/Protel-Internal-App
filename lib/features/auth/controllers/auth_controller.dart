// lib/features/auth/controllers/auth_controller.dart

import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;
  final Rx<String?> token = Rx<String?>(null);
  final Rx<String?> userRole = Rx<String?>(null);

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      final authResponse = await _authService.login(username, password);
      token.value = authResponse.token;
      userRole.value = authResponse.role;

      switch (authResponse.role) {
        case 'mekanik':
          Get.offAllNamed('/mechanic-home');  // Make sure this route exists in main.dart
          break;
        case 'satpam':
          Get.offAllNamed('/security-home');
          break;
        default:
          Get.snackbar('Error', 'Unauthorized role');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    token.value = null;
    userRole.value = null;
    Get.offAllNamed('/login');
  }
}