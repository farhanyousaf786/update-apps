import 'pages/AppsListScreen.dart';
import 'pages/SystemInfo.dart';
import 'pages/UninstallAppsListScreen.dart';
import 'package:app_updates/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';
import 'pages/SystemAppsListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Updates',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const DashBoard(
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
//flutter build apk --target-platform=android-arm64
//flutter build appbundle --target-platform android-arm,android-arm64
//keytool -genkey -v -keystore D:\IT\Pro\appKeys\updateAppKey\update_apps.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload