// lib/features/mechanic/screens/sparepart_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import '../controllers/sparepart_controller.dart';
import '../widgets/sparepart_result_dialog.dart';
import '../../../data/services/sparepart_service.dart';
import 'package:intl/intl.dart';

class SparepartScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final SparepartController controller = Get.find<SparepartController>();

  SparepartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Role : Mekanik',
                    style: TextStyle(
                      fontSize: 20,
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

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F7FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari Sparepart',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onChanged: (value) => controller.filterSpareparts(value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        searchController.clear();
                        controller.filterSpareparts('');
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Sparepart List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final spareparts = controller.filteredSpareparts;

                if (spareparts.isEmpty) {
                  return const Center(child: Text('No spareparts found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: spareparts.length,
                  itemBuilder: (context, index) {
                    final sparepart = spareparts[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(sparepart.namaPart),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Part Number: ${sparepart.number}'),
                            Text('Stock: ${sparepart.stock}'),
                            Text(
                              'Harga: Rp ${NumberFormat('#,###').format(sparepart.harga)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              }),
            ),

            CustomBottomNavbar(
              currentRoute: '/mechanic-sparepart',
              showMechanicMenu: true,
            ),
          ],
        ),
      ),
    );
  }
}