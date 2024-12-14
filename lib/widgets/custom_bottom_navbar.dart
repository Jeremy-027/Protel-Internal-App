// lib/widgets/custom_bottom_navbar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavbar extends StatelessWidget {
  final String currentRoute;
  final bool showMechanicMenu;

  const CustomBottomNavbar({
    Key? key,
    required this.currentRoute,
    this.showMechanicMenu = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: showMechanicMenu ? _buildMechanicMenu() : _buildSecurityMenu(),
      ),
    );
  }

  List<Widget> _buildMechanicMenu() {
    return [
      _buildNavItem(
        Icons.settings,
        'PKB on Service',
        currentRoute == '/mechanic-home',
            () => Get.offAllNamed('/mechanic-home'),
      ),
      _buildNavItem(
        Icons.build,
        'Sparepart',
        currentRoute == '/mechanic-sparepart',
            () => Get.offAllNamed('/mechanic-sparepart'),
      ),
      _buildNavItem(
        Icons.logout,
        'Log Out',
        false,
            () => Get.offAllNamed('/login'),
      ),
    ];
  }

  List<Widget> _buildSecurityMenu() {
    return [
      _buildNavItem(
        Icons.folder_outlined,
        'Input',
        currentRoute == '/security-home',
            () => Get.offAllNamed('/security-home'),
      ),
      _buildNavItem(
        Icons.access_time,
        'Masuk',
        currentRoute == '/security-list',
            () => Get.offAllNamed('/security-list'),
      ),
      _buildNavItem(
        Icons.logout,
        'Log Out',
        false,
            () => Get.offAllNamed('/login'),
      ),
    ];
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF4A3780) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF4A3780) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}