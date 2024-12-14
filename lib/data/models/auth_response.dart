// lib/data/models/auth_response.dart
import 'package:dio/dio.dart';
import '../models/auth_response.dart';
import 'dart:convert';


class AuthResponse {
  final String message;
  final String token;
  final String role;

  AuthResponse({
    required this.message,
    required this.token,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      role: _extractRoleFromToken(json['token'] ?? ''),
    );
  }

  static String _extractRoleFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return '';

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final data = json.decode(decoded);

      return data['role'] ?? '';
    } catch (e) {
      return '';
    }
  }
}