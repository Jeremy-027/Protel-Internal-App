// lib/data/models/pkb.dart

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
      id: json['_id'],
      noPolisi: json['noPolisi'],
      noRangka: json['noRangka'],
      noMesin: json['noMesin'],
      tipe: json['tipe'],
      tahun: json['tahun'],
      produk: json['produk'],
      kilometer: json['kilometer'],
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
  final List<Layanan> layanan;
  final List<Sparepart> spareparts;
  final String responsMekanik;
  final Customer customer;
  final Vehicle vehicle;

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
    required this.vehicle,
  });

  factory PKB.fromJson(Map<String, dynamic> json) {
    return PKB(
      id: json['_id'],
      noPkb: json['noPkb'],
      tanggalWaktu: DateTime.parse(json['tanggalWaktu']),
      kilometer: json['kilometer'],
      keluhan: json['keluhan'],
      namaMekanik: json['namaMekanik'],
      namaSa: json['namaSa'],
      layanan: (json['layanan'] as List)
          .map((l) => Layanan.fromJson(l))
          .toList(),
      spareparts: (json['spareparts'] as List)
          .map((s) => Sparepart.fromJson(s))
          .toList(),
      responsMekanik: json['responsMekanik'],
      customer: Customer.fromJson(json['customer']),
      vehicle: Vehicle.fromJson(json['vehicle']),
    );
  }
}