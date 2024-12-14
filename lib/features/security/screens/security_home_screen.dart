// lib/features/security/screens/security_home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/security_controller.dart';
import '../../../data/models/service.dart';
import '../../../widgets/custom_bottom_navbar.dart';

class SecurityHomeScreen extends StatefulWidget {
  const SecurityHomeScreen({Key? key}) : super(key: key);

  @override
  State<SecurityHomeScreen> createState() => _SecurityHomeScreenState();
}

class _SecurityHomeScreenState extends State<SecurityHomeScreen> {
  final _nomorPolisiController = TextEditingController();
  final _kilometerController = TextEditingController();
  final _tanggalController = TextEditingController();
  final SecurityController controller = Get.find<SecurityController>();

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
                    height: 40,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      'No Polisi Kendaraan',
                      _nomorPolisiController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      'Kilometer Kendaraan',
                      _kilometerController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildDateField(
                      'Tanggal Masuk',
                      _tanggalController,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitEntry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A3780),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Kendaraan Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomBottomNavbar(currentRoute: '/security-home'),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
        TextCapitalization textCapitalization = TextCapitalization.none,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A3780),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () => controller.clear(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A3780),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.grey),
              onPressed: () => _selectDate(context),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitEntry() async {
    if (_nomorPolisiController.text.isEmpty ||
        _kilometerController.text.isEmpty ||
        _tanggalController.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return;
    }

    await controller.createService(
      _nomorPolisiController.text,
      _kilometerController.text,
      DateTime.now(),
    );
    _nomorPolisiController.clear();
    _kilometerController.clear();
    _tanggalController.clear();
  }
}