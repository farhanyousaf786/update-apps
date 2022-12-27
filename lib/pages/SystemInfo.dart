import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
//   }
// }

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({Key? key}) : super(key: key);

  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData =
              _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'Version.securityPatch': build.version.securityPatch,
      'Version.sdkInt': build.version.sdkInt,
      'Version.release': build.version.release,
      'Version.previewSdkInt': build.version.previewSdkInt,
      'Version.incremental': build.version.incremental,
      'Version.codename': build.version.codename,
      'Version.baseOS': build.version.baseOS,
      'Board': build.board,
      'Bootloader': build.bootloader,
      'Brand': build.brand,
      'Device': build.device,
      'Display': build.display,
      'Fingerprint': build.fingerprint,
      'Hardware': build.hardware,
      'Host': build.host,
      'Id': build.id,
      'Manufacturer': build.manufacturer,
      'Model': build.model,
      'Product': build.product,
      'Supported32BitAbis': build.supported32BitAbis,
      'Supported64BitAbis': build.supported64BitAbis,
      'SupportedAbis': build.supportedAbis,
      'Tags': build.tags,
      'Type': build.type,
      'IsPhysicalDevice': build.isPhysicalDevice,
      'AndroidId': build.androidId,
      'SystemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade500,

        appBar: AppBar(
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          centerTitle:  true,
          title: Text(
            kIsWeb
                ? 'Web Browser info'
                : Platform.isAndroid
                ? 'Android Device Info'
                : Platform.isIOS
                ? 'iOS Device Info'
                : Platform.isLinux
                ? 'Linux Device Info'
                : Platform.isMacOS
                ? 'MacOS Device Info'
                : Platform.isWindows
                ? 'Windows Device Info'
                : '',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index){
              String key = _deviceData.keys.elementAt(index);

              return Container(
                  padding: const EdgeInsets.all(10),
                  color: index%2==0?Colors.green.withOpacity(0.5):Colors.grey.withOpacity(0.5),
                  child:Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Text(
                              '${_deviceData[key]}',
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                  )
              );
            },
            itemCount: _deviceData.length,
          ),
        )
      // ListView(
      //   children: _deviceData.keys.map(
      //         (String property) {
      //       return
      //       Row(
      //         children: <Widget>[
      //           Container(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Text(
      //               property,
      //               style: const TextStyle(
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //               child: Container(
      //                 padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      //                 child: Text(
      //                   '${_deviceData[property]}',
      //                   maxLines: 10,
      //                   overflow: TextOverflow.ellipsis,
      //                 ),
      //               )),
      //         ],
      //       );
      //     },
      //   ).toList(),
      // ),
    );
  }
}