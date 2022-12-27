import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class AppDetailsScreen extends StatelessWidget {
  const AppDetailsScreen({Key? key,required this.application,this.icon}) : super(key: key);

  final Application application;
  final Uint8List? icon;
  @override
  Widget build(BuildContext context) {
    // if(DeviceApps.getApp(application.packageName,true)==ApplicationWithIcon){
    //
    // }
    //ApplicationWithIcon app =
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:true,
      ),
      body: Container(
        color:Colors.white70,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.green,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: MemoryImage(icon!),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 15,),
                  Text(application.appName,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
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
                            SizedBox(height: 10,),
                            Text("Check For Update", style: TextStyle(fontSize:16, fontWeight: FontWeight.bold,color: Colors.black87),),
                            SizedBox(height: 10,),
                            Text('New Update Available', style: TextStyle(color: Colors.grey, fontSize: 12),)
                            ,SizedBox(height: 10,),
                          ],
                        ),
                        const VerticalDivider(color: Colors.green,thickness: 1.5,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10,),
                            const Text("Current Version", style: TextStyle(fontSize:16, fontWeight: FontWeight.bold,color: Colors.black87),),
                            const SizedBox(height: 10,),
                            Text(application.versionName.toString(), style: TextStyle(color: Colors.grey, fontSize: 12),)
                            ,const SizedBox(height: 10,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      StoreRedirect.redirect(androidAppId: application.packageName);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        minimumSize:MaterialStateProperty.all<Size>( const Size( double.infinity,40)),
                        
                    ),
                    child: const Text('New Update Available',style: TextStyle(color: Colors.white),),)
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                // OpenStore.instance.open(
                //   androidAppBundleId: application.packageName,
                // );
                StoreRedirect.redirect(androidAppId: application.packageName);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Text(
                      "Open in Store",
                      //textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Image.asset('assets/images/apps.png',width: 40, height: 40,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: () async {
                application.openApp();
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Text(
                      "Open App",
                      //textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Image.asset('assets/images/app_launch.png',width: 40, height: 40,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: () async {
                if(await application.uninstallApp()){
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
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Text(
                      "Un-install app",
                      //textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Image.asset('assets/images/delete_app.png',width: 40, height: 40,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
