class Service {
  final String id;
  final String noPolisi;
  final int kilometer;
  final DateTime tanggalMasuk;
  final DateTime createdAt;
  final DateTime updatedAt;

  Service({
    required this.id,
    required this.noPolisi,
    required this.kilometer,
    required this.tanggalMasuk,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      noPolisi: json['noPolisi'],
      kilometer: json['kilometer'],
      tanggalMasuk: DateTime.parse(json['tanggalMasuk']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noPolisi': noPolisi,
      'kilometer': kilometer,
      'tanggalMasuk': tanggalMasuk.toIso8601String(),
    };
  }
}