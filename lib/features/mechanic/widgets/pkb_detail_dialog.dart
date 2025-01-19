// lib/features/mechanic/widgets/pkb_detail_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/pkb.dart';
import '../controllers/mechanic_controller.dart';

class PKBDetailDialog extends StatelessWidget {
  final PKB pkb;
  final TextEditingController _responseController = TextEditingController();
  final MechanicController _mechanicController = Get.find<MechanicController>();

  PKBDetailDialog({
    Key? key,
    required this.pkb,
  }) : super(key: key) {
    _responseController.text = pkb.responsMekanik;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              Text(
                'No. PKB : ${pkb.noPkb}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tanggal Masuk : ${DateFormat('dd/MM/yyyy   HH:mm').format(pkb.tanggalWaktu)}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),

              // Vehicle Details
              if (pkb.vehicle != null) ...[
                Text('No. Polisi : ${pkb.vehicle!.noPolisi}', style: TextStyle(fontSize: 14)),
                Text('Kilometer : ${pkb.kilometer}', style: TextStyle(fontSize: 14)),
                Text('No. Rangka : ${pkb.vehicle!.noRangka}', style: TextStyle(fontSize: 14)),
                Text('No. Mesin : ${pkb.vehicle!.noMesin}', style: TextStyle(fontSize: 14)),
                Text('Type : ${pkb.vehicle!.tipe}', style: TextStyle(fontSize: 14)),
                Text('Tahun : ${pkb.vehicle!.tahun}', style: TextStyle(fontSize: 14)),
                Text('Produk : ${pkb.vehicle!.produk}', style: TextStyle(fontSize: 14)),
              ],

              if (pkb.summary != null) ...[
                SizedBox(height: 16),
                Text('Summary:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ...pkb.summary!.layanan.map((layanan) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ${layanan.namaLayanan} (${layanan.quantity}x)',
                          style: TextStyle(fontSize: 14)),
                      Text('  Harga: Rp ${NumberFormat('#,###').format(layanan.total)}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                )),
                SizedBox(height: 8),
                ...pkb.summary!.sparepart.map((sparepart) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ${sparepart.namaPart} (${sparepart.quantity}x)',
                          style: TextStyle(fontSize: 14)),
                      Text('  Harga: Rp ${NumberFormat('#,###').format(sparepart.total)}',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                )),
                SizedBox(height: 8),
                Text('Total Harga: Rp ${NumberFormat('#,###').format(pkb.summary!.totalHarga)}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],

              // Keluhan Section
              SizedBox(height: 16),
              Text('Keluhan:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(pkb.keluhan, style: TextStyle(fontSize: 14)),
              ),

              // Response Mekanik Section
              SizedBox(height: 16),
              Text('Response Mekanik:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _responseController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Ketik response...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.edit, color: Color(0xFF4A3780)),
                    ),
                  ),
                ),
              ),

              // Buttons
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Batal',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await _mechanicController.updatePKBResponse(
                          pkb.id,
                          _responseController.text,
                        );
                        Get.back();
                        Get.snackbar(
                          'Success',
                          'Response berhasil disimpan',
                          backgroundColor: Colors.green.withOpacity(0.7),
                          colorText: Colors.white,
                        );
                      } catch (e) {
                        Get.snackbar(
                          'Error',
                          'Gagal menyimpan response',
                          backgroundColor: Colors.red.withOpacity(0.7),
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A3780),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}