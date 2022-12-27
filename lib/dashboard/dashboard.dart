import 'package:facebook_audience_network/facebook_audience_network.dart';
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
    _showNativeAd();
    // Future.delayed(const Duration(seconds: 30), () {
    //   _showInterstitialAd();
    //
    // });

    super.initState();
  }

  bool _isInterstitialAdLoaded = false;

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "1336093853816192_1336095053816072",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  _showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      //1316724952486390_1316726822486203
      placementId: "1336093853816192_1336094377149473",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

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


                    Row(children: [
                      Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width/2.5,
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
                        width: MediaQuery.of(context).size.width/2.5,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SystemAppsListScreen()));
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
                      ),],),



                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UninstallAppsListScreen()));
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
                    TextButton(
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
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DeviceInfoScreen()));
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
                    TextButton(
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
                    SizedBox(height: 300,)

                  ],
                ),
              )
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Align(
          alignment: Alignment(0, 1.0),
          child: _currentAd,
        ),
      )
    ]);
  }
}
