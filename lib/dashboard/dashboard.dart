import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/AppsListScreen.dart';
import '../pages/SystemAppsListScreen.dart';
import '../pages/SystemInfo.dart';
import '../pages/UninstallAppsListScreen.dart';
import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    FacebookAudienceNetwork.init();
    _loadInterstitialAd();
    myBanner.load();

    // _showNativeAd();
    Future.delayed(const Duration(seconds: 10), () {
      _interstitialAd?.show();
    });

    super.initState();
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-5525086149175557/9611255731',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

// TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-5525086149175557/3237419076",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  // Widget _currentAd = SizedBox(
  //   width: 0.0,
  //   height: 0.0,
  // );
  //
  // _showNativeAd() {
  //   setState(() {
  //     _currentAd = _nativeAd();
  //   });
  // }

  // Widget _nativeAd() {
  //   return FacebookNativeAd(
  //     placementId: "1336093853816192_1336094377149473",
  //     adType: NativeAdType.NATIVE_AD_VERTICAL,
  //     width: double.infinity,
  //     height: 300,
  //     backgroundColor: Colors.blue,
  //     titleColor: Colors.white,
  //     descriptionColor: Colors.white,
  //     buttonColor: Colors.deepPurple,
  //     buttonTitleColor: Colors.white,
  //     buttonBorderColor: Colors.white,
  //     listener: (result, value) {
  //       print("Native Ad: $result --> $value");
  //     },
  //     keepExpandedWhileLoading: true,
  //     expandAnimationDuraion: 1000,
  //   );
  // }

  /// This function will lead us to browser to run a url.
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );

    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade600.withOpacity(0.98),
          elevation: 0.0,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(30),
          //   ),
          // ),
          centerTitle: true,
          title: const Text(
            "App Tools",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontFamily: 'bal'),
          ),
          actions: [
            GestureDetector(
              onTap: () => {
                _launchURL("https://sites.google.com/view/updateallapps/home"),
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 4, right: 10, top: 4),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade700, Colors.blue.shade300]),
          ),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AppsListScreen()));
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/apps.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "User Apps",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'bal'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SystemAppsListScreen()));
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/system_apps.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "System Apps",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'bal'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UninstallAppsListScreen()));
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/delete_app.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Un-install App",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'bal'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextButton(
                              onPressed: () {
                                SystemSettings.deviceInfo();
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/system_update.png',
                                      width: 40,
                                      height: 40.0,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "System Update",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'bal'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const DeviceInfoScreen()));
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(20),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/cpu.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Processor",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'bal'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextButton(
                              onPressed: () {
                                _launchURL(
                                    "https://play.google.com/store/apps/details?id=com.ushnfay.todo");
                              },
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/storage.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "To-Do App",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'bal'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Align(
          alignment: Alignment(0, 1.0),
          child: adContainer,
        ),
      ),
    ]);
  }
}
