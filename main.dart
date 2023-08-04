import 'dart:io';

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/journeys/home/home.dart';
import 'package:dairy_products/persentation/journeys/sample1.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SharedStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 24, 97, 156),
      theme: ThemeData(
          datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: Color.fromARGB(255, 24, 97, 156),
              todayBackgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 24, 97, 156))),
          bannerTheme: const MaterialBannerThemeData(
              backgroundColor: Color.fromARGB(255, 24, 97, 156))),
      debugShowCheckedModeBanner: false,
      home: SharedStorage.getString(ApiConfig.userId, "") == ""
          ? const MyWidget()
          : const HomePage(),
    );
  }
}
