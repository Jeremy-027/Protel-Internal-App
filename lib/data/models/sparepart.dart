// lib/data/models/sparepart.dart

class Sparepart {
  final String id;
  final String namaPart;
  final String number;
  final int stock;
  final int harga;
  final DateTime createdAt;

  Sparepart({
    required this.id,
    required this.namaPart,
    required this.number,
    required this.stock,
    required this.harga,
    required this.createdAt,
  });

  factory Sparepart.fromJson(Map<String, dynamic> json) {
    return Sparepart(
      id: json['_id'],
      namaPart: json['namaPart'],
      number: json['number'],
      stock: json['stock'],
      harga: json['harga'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}