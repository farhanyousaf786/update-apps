import 'dart:typed_data';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class AppDetailsScreen extends StatefulWidget {
  const AppDetailsScreen({Key? key, required this.application, this.icon})
      : super(key: key);

  final Application application;
  final Uint8List? icon;

  @override
  State<AppDetailsScreen> createState() => _AppDetailsScreenState();
}

class _AppDetailsScreenState extends State<AppDetailsScreen> {

  NativeAd? nativeAd;
  bool isNativeAdLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadNativeAd();
  }

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: "ca-app-pub-5525086149175557/5729959934",
      factoryId: "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {
        setState(() {
          isNativeAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        nativeAd!.dispose();
      }),
      request: const AdRequest(),
    );
    nativeAd!.load();
  }


  @override
  Widget build(BuildContext context) {
    // if(DeviceApps.getApp(application.packageName,true)==ApplicationWithIcon){
    //
    // }
    //ApplicationWithIcon app =
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.application.appName,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'bal'),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: CircleAvatar(
                radius: 18,
                backgroundImage: MemoryImage(widget.icon!),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  elevation: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Check For Update",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'New Update Available',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontFamily: 'bal'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.blue,
                                thickness: 1.5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Current Version",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontFamily: 'bal'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.application.versionName.toString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontFamily: 'bal'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            StoreRedirect.redirect(
                                androidAppId: widget.application.packageName);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(double.infinity, 40)),
                          ),
                          child: const Text(
                            'New Update Available',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'bal'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // OpenStore.instance.open(
                  //   androidAppBundleId: application.packageName,
                  // );
                  StoreRedirect.redirect(
                      androidAppId: widget.application.packageName);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Open in Store",
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bal'),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/apps.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  widget.application.openApp();
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Open App",
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bal'),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/app_launch.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  if (await widget.application.uninstallApp()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("App un-installed!"),
                    ));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Un-install app",
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bal'),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/delete_app.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Align(
                  alignment: Alignment(0, 1.0),
                  child: isNativeAdLoaded
                      ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    height: 300,
                    child: AdWidget(
                      ad: nativeAd!,
                    ),
                  )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
