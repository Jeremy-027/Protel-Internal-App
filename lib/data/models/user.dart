// lib/data/models/user.dart

enum UserRole { admin, customer, SA, sparepart, satpam, mekanik }

class User {
  final String id;
  final String username;
  final String password;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] is Map ? json['_id']['\$oid'] : json['_id'],
      username: json['username'],
      password: json['password'],
      role: _stringToRole(json['role']),
      createdAt: json['createdAt'] is Map
          ? DateTime.parse(json['createdAt']['\$date'])
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] is Map
          ? DateTime.parse(json['updatedAt']['\$date'])
          : DateTime.parse(json['updatedAt']),
    );
  }

  static UserRole _stringToRole(String role) {
    switch (role) {
      case 'admin': return UserRole.admin;
      case 'customer': return UserRole.customer;
      case 'SA': return UserRole.SA;
      case 'sparepart': return UserRole.sparepart;
      case 'satpam': return UserRole.satpam;
      case 'mekanik': return UserRole.mekanik;
      default: throw Exception('Invalid role: $role');
    }
  }
}