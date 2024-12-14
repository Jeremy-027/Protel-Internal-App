// lib/features/mechanic/screens/sparepart_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_bottom_navbar.dart';
import '../controllers/sparepart_controller.dart';
import '../widgets/sparepart_result_dialog.dart';

class SparepartScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final SparepartController controller = Get.put(SparepartController());

  SparepartScreen({Key? key}) : super(key: key);

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
                      fontSize: 20,
                      color: Color(0xFF4A3780),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F7FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari Sparepart',
                    prefixIcon: const Icon(Icons.arrow_back),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        controller.clearSearch();
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15)
                  ),
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      await controller.searchSpareparts(value);
                    } else {
                      controller.clearSearch();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return const Center(child: Text('Tidak ada hasil'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final sparepart = controller.searchResults[index];
                    return ListTile(
                      title: Text(sparepart.namaPart),
                      subtitle: Text(sparepart.number),
                      onTap: () {
                        Get.dialog(SparepartResultDialog(sparepart: sparepart));
                      },
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