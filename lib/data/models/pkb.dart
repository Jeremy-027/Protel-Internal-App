// lib/data/models/pkb.dart
class Summary {
  final String id;
  final List<LayananSummary> layanan;
  final List<SparepartSummary> sparepart;
  final int totalHarga;
  final DateTime createdAt;

  Summary({
    required this.id,
    required this.layanan,
    required this.sparepart,
    required this.totalHarga,
    required this.createdAt,
  });

  factory Summary.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Summary(
      id: '',
      layanan: [],
      sparepart: [],
      totalHarga: 0,
      createdAt: DateTime.now(),
    );

    return Summary(
      id: json['_id'],
      layanan: (json['layanan'] as List).map((l) => LayananSummary.fromJson(l)).toList(),
      sparepart: (json['sparepart'] as List).map((s) => SparepartSummary.fromJson(s)).toList(),
      totalHarga: json['totalHarga'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class LayananSummary {
  final String namaLayanan;
  final int quantity;
  final int harga;
  final int total;

  LayananSummary({
    required this.namaLayanan,
    required this.quantity,
    required this.harga,
    required this.total,
  });

  factory LayananSummary.fromJson(Map<String, dynamic> json) {
    return LayananSummary(
      namaLayanan: json['namaLayanan'],
      quantity: json['quantity'],
      harga: json['harga'],
      total: json['total'],
    );
  }
}

class SparepartSummary {
  final String namaPart;
  final int quantity;
  final int harga;
  final int total;

  SparepartSummary({
    required this.namaPart,
    required this.quantity,
    required this.harga,
    required this.total,
  });

  factory SparepartSummary.fromJson(Map<String, dynamic> json) {
    return SparepartSummary(
      namaPart: json['namaPart'],
      quantity: json['quantity'],
      harga: json['harga'],
      total: json['total'],
    );
  }
}

class Layanan {
  final String id;
  final String namaLayanan;
  final int harga;

  Layanan({
    required this.id,
    required this.namaLayanan,
    required this.harga,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      id: json['_id'],
      namaLayanan: json['namaLayanan'],
      harga: json['harga'],
    );
  }
}

class Sparepart {
  final String id;
  final String namaPart;
  final String number;
  final int stock;
  final int harga;

  Sparepart({
    required this.id,
    required this.namaPart,
    required this.number,
    required this.stock,
    required this.harga,
  });

  factory Sparepart.fromJson(Map<String, dynamic> json) {
    return Sparepart(
      id: json['_id'],
      namaPart: json['namaPart'],
      number: json['number'],
      stock: json['stock'],
      harga: json['harga'],
    );
  }
}

class Customer {
  final String id;
  final String nama;
  final String alamat;
  final int noTelp;

  Customer({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.noTelp,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'],
      nama: json['nama'],
      alamat: json['alamat'],
      noTelp: json['noTelp'],
    );
  }
}

class Vehicle {
  final String id;
  final String noPolisi;
  final String noRangka;
  final String noMesin;
  final String tipe;
  final int tahun;
  final String produk;
  final int kilometer;

  Vehicle({
    required this.id,
    required this.noPolisi,
    required this.noRangka,
    required this.noMesin,
    required this.tipe,
    required this.tahun,
    required this.produk,
    required this.kilometer,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'] ?? 'N/A',
      noPolisi: json['noPolisi'] ?? 'N/A',
      noRangka: json['noRangka'] ?? 'N/A',
      noMesin: json['noMesin'] ?? 'N/A',
      tipe: json['tipe'] ?? 'N/A',
      tahun: json['tahun'] ?? 0,
      produk: json['produk'] ?? 'N/A',
      kilometer: json['kilometer'] ?? 0,
    );
  }
}

class PKB {
  final String id;
  final String noPkb;
  final DateTime tanggalWaktu;
  final int kilometer;
  final String keluhan;
  final String namaMekanik;
  final String namaSa;
  final List<String> layanan; // Changed to List<String>
  final List<String> spareparts; // Changed to List<String>
  final String responsMekanik;
  final Customer customer;
  final Vehicle? vehicle; // Made nullable
  final Summary? summary; // Added summary


  PKB({
    required this.id,
    required this.noPkb,
    required this.tanggalWaktu,
    required this.kilometer,
    required this.keluhan,
    required this.namaMekanik,
    required this.namaSa,
    required this.layanan,
    required this.spareparts,
    required this.responsMekanik,
    required this.customer,
    this.vehicle,
    this.summary,
  });

  factory PKB.fromJson(Map<String, dynamic> json) {
    try {
      return PKB(
        id: json['_id'] ?? '',
        noPkb: json['noPkb'] ?? '',
        tanggalWaktu: json['tanggalWaktu'] != null
            ? DateTime.parse(json['tanggalWaktu'])
            : DateTime.now(),
        kilometer: json['kilometer'] ?? 0,
        keluhan: json['keluhan'] ?? '',
        namaMekanik: json['namaMekanik'] ?? '',
        namaSa: json['namaSa'] ?? '',
        layanan: (json['layanan'] as List?)
            ?.map((e) => e.toString())
            .toList() ?? [],
        spareparts: (json['spareparts'] as List?)
            ?.map((e) => e.toString())
            .toList() ?? [],
        responsMekanik: json['responsMekanik'] ?? '-',
        customer: Customer.fromJson(json['customer'] ?? {}),
        vehicle: json['vehicle'] != null
            ? Vehicle.fromJson(json['vehicle'])
            : null,
        summary: json['summary'] != null
            ? Summary.fromJson(json['summary'])
            : null,
      );
    } catch (e) {
      print('Error parsing PKB: $e');
      print('JSON data: $json');
      rethrow;
    }
  }
}