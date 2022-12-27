import 'dart:typed_data';
import 'app_details.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppsListScreen extends StatefulWidget {
  const AppsListScreen({Key? key}) : super(key: key);

  @override
  _AppsListScreenState createState() => _AppsListScreenState();
}

class _AppsListScreenState extends State<AppsListScreen> {
  final bool _showSystemApps = false;
  final bool _onlyLaunchableApps = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      appBar: AppBar(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        centerTitle: true,
        title: const Text('Update Apps'),
      ),
      body: _AppsListScreenContent(
          includeSystemApps: _showSystemApps,
          onlyAppsWithLaunchIntent: _onlyLaunchableApps,
          key: GlobalKey()),
    );
  }
}

class _AppsListScreenContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  const _AppsListScreenContent(
      {Key? key,
      this.includeSystemApps = false,
      this.onlyAppsWithLaunchIntent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DeviceApps.listenToAppsChanges(),
        builder: (
          BuildContext context,
          AsyncSnapshot<ApplicationEvent> snapshot,
        ) {
          return FutureBuilder<List<Application>>(
            future: DeviceApps.getInstalledApplications(
                includeAppIcons: true,
                includeSystemApps: includeSystemApps,
                onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent),
            builder:
                (BuildContext context, AsyncSnapshot<List<Application>> data) {
              if (data.data == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cheking Updates..",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                List<Application> apps = data.data!;

                return Scrollbar(
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int position) {
                          Application app = apps[position];
                          Uint8List? icon =
                              app is ApplicationWithIcon ? app.icon : null;
                          return Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: app is ApplicationWithIcon
                                      ? CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                              MemoryImage(app.icon),
                                          backgroundColor: Colors.white,
                                        )
                                      : null,
                                  onTap: () {},
                                  title: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          app.appName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          app.packageName,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Text('Version: ${app.versionName}\n'
                                  //     'System app: ${app.systemApp}\n'
                                  //     'APK file path: ${app.apkFilePath}\n'
                                  //     'Data dir: ${app.dataDir}\n'
                                  //     'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
                                  //     'Updated: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}'
                                  // ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Install Date : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              DateFormat('dd.MM.yyyy')
                                                  .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          app.installTimeMillis))
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Update Date : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              DateFormat('dd.MM.yyyy')
                                                  .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          app.updateTimeMillis))
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Version : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            app.versionName.toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              overflow: TextOverflow.clip,
                                            ),
                                          )
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          onAppClicked(context, app, icon);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.green),
                                            minimumSize:
                                                MaterialStateProperty.all<Size>(
                                                    const Size(
                                                        double.infinity, 40))),
                                        child: const Text(
                                          'Check App Update',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // const Divider(
                                //   height: 1.0,
                                // )
                              ],
                            ),
                          );
                        },
                        itemCount: apps.length),
                  ),
                );
              }
            },
          );
        });
  }

  void onAppClicked(BuildContext context, Application app, Uint8List? icon) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AppDetailsScreen(
              application: app,
              icon: icon,
            )));
  }
}
