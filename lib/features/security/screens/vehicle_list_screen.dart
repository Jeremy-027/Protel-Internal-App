// lib/features/security/screens/vehicle_list_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/security_controller.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import 'package:intl/intl.dart';

// lib/features/security/screens/vehicle_list_screen.dart

class VehicleListScreen extends StatelessWidget {
  final SecurityController controller = Get.find<SecurityController>();

  VehicleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Role : Satpam',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF4A3780),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.services.isEmpty) {
                  return const Center(child: Text('No vehicle entries found'));
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchServices(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: controller.services.length,
                    itemBuilder: (context, index) {
                      final service = controller.services[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F7FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE6E1F4),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Color(0xFF4A3780),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No Polisi: ${service.noPolisi}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Kilometer: ${service.kilometer}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tanggal Masuk: ${DateFormat('dd/MM/yyyy HH:mm').format(service.tanggalMasuk)}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            CustomBottomNavbar(currentRoute: '/security-list'),
          ],
        ),
      ),
    );
  }
}