import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_updates/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

String? version;
List<String> testDeviceIds = ['1ABD59FEDD8208ABF827341092618E9D'];


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  RequestConfiguration configuration =
  RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);

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
      home: const DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
//flutter build apk --target-platform=android-arm64
//flutter build appbundle --target-platform android-arm,android-arm64
//keytool -genkey -v -keystore D:\IT\Pro\appKeys\updateAppKey\update_apps.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
