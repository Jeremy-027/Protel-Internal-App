// lib/data/models/vehicle_entry.dart

class VehicleEntry {
  final String? id;
  final String nomorPolisi;
  final String kilometer;  // Changed to String to match form input
  final String tanggalMasuk;  // Changed to String to match form input
  final String? sa;
  final String? karu;
  final String? mekanik;
  final String? billing;

  VehicleEntry({
    this.id,
    required this.nomorPolisi,
    required this.kilometer,
    required this.tanggalMasuk,
    this.sa,
    this.karu,
    this.mekanik,
    this.billing,
  });

  Map<String, dynamic> toJson() {
    return {
      'nomorPolisi': nomorPolisi,
      'kilometer': kilometer,
      'tanggalMasuk': tanggalMasuk,
      'sa': sa,
      'karu': karu,
      'mekanik': mekanik,
      'billing': billing,
    };
  }

  factory VehicleEntry.fromJson(Map<String, dynamic> json) {
    return VehicleEntry(
      id: json['_id'],
      nomorPolisi: json['nomorPolisi'],
      kilometer: json['kilometer'],
      tanggalMasuk: json['tanggalMasuk'],
      sa: json['sa'],
      karu: json['karu'],
      mekanik: json['mekanik'],
      billing: json['billing'],
    );
  }
}