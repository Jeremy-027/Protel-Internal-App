// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/security/screens/security_home_screen.dart';
import 'features/security/screens/vehicle_list_screen.dart';
import 'features/mechanic/screens/mechanic_home_screen.dart';
import 'features/mechanic/screens/sparepart_screen.dart';
import 'features/security/controllers/security_controller.dart';
import 'data/services/service_api.dart';
import 'features/auth/controllers/auth_controller.dart';

// lib/main.dart

void main() {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.18.249:5000/api',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ))..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    error: true,
  ));

  print('Attempting to connect to: http://192.168.18.249:5000/api');

  final serviceApi = ServiceApi(dio);

  runApp(MyApp(serviceApi: serviceApi));
}

class MyApp extends StatelessWidget {
  final ServiceApi serviceApi;

  const MyApp({super.key, required this.serviceApi});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Astra Isuzu Internal',
      theme: ThemeData(
        primaryColor: const Color(0xFF4A3780),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A3780),
        ),
      ),
      initialRoute: '/login',
      initialBinding: BindingsBuilder(() {
        Get.put(SecurityController(serviceApi));
        Get.put(AuthController());
      }),
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/security-home',
          page: () => SecurityHomeScreen(),
        ),
        GetPage(
          name: '/security-list',
          page: () => VehicleListScreen(),
        ),
        GetPage(
          name: '/mechanic-home',
          page: () => MechanicHomeScreen(),
        ),
        GetPage(
          name: '/mechanic-sparepart',
          page: () => SparepartScreen(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}