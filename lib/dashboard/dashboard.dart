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
            ),
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
              padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
              child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(15),
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    TextButton(
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
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ],
                        )),
                      ),
                    ),
                    TextButton(
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
                                color: Colors.blue.shade600,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
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
                              style: TextStyle(color: Colors.blue.shade600),
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
                              style: TextStyle(color: Colors.blue.shade700),
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
                              style: TextStyle(color: Colors.blue.shade600),
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
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),

    ]);
  }
}
