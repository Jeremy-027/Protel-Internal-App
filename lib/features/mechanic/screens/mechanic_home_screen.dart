// lib/features/mechanic/screens/mechanic_home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/mechanic_controller.dart';
import '../../../data/models/pkb.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import '../widgets/pkb_detail_dialog.dart';

class MechanicHomeScreen extends StatelessWidget {
  final MechanicController controller = Get.find<MechanicController>();

  MechanicHomeScreen({Key? key}) : super(key: key);

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
                    'Role : Mekanik',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A3780),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.pkbs.isEmpty) {
                  return const Center(child: Text('No PKB available'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: controller.pkbs.length,
                  itemBuilder: (context, index) {
                    final pkb = controller.pkbs[index];
                    return _buildPKBCard(index + 1, pkb);
                  },
                );
              }),
            ),
            CustomBottomNavbar(
              currentRoute: '/mechanic-home',
              showMechanicMenu: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPKBCard(int number, PKB pkb) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6E1F4),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      fontSize: 14,
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
                      'No PKB: ${pkb.noPkb}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (pkb.vehicle != null) ...[
                      Text(
                        'No Polisi: ${pkb.vehicle!.noPolisi}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      'Tanggal Masuk: ${DateFormat('dd/MM/yyyy   HH:mm').format(pkb.tanggalWaktu)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    if (pkb.summary != null) ...[
                      Text(
                        'Total: Rp ${NumberFormat('#,###').format(pkb.summary!.totalHarga)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Get.dialog(PKBDetailDialog(pkb: pkb)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A3780),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Detail PKB',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}