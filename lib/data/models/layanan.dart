// lib/data/models/layanan.dart

class Layanan {
  final String id;
  final String namaLayanan;
  final int harga;
  final DateTime createdAt;

  Layanan({
    required this.id,
    required this.namaLayanan,
    required this.harga,
    required this.createdAt,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      id: json['_id'],
      namaLayanan: json['namaLayanan'],
      harga: json['harga'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'namaLayanan': namaLayanan,
      'harga': harga,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}