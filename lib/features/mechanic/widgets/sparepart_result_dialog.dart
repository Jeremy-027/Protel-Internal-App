// lib/features/mechanic/widgets/sparepart_result_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/sparepart.dart';

class SparepartResultDialog extends StatelessWidget {
  final Sparepart sparepart;

  const SparepartResultDialog({
    Key? key,
    required this.sparepart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  const TextSpan(
                    text: 'Nama Sparepart :\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '"${sparepart.namaPart}"',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  const TextSpan(
                    text: 'Nama Sparepart :\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '"${sparepart.number}"',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  const TextSpan(
                    text: 'Stok Sparepart :\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '"${sparepart.stock}"',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A3780),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tutup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}