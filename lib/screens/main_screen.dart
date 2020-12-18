import 'package:APKExtractorPRO/screens/about.dart';
import 'package:APKExtractorPRO/utils/constants.dart';
import 'package:APKExtractorPRO/widgets/app_item.dart';
import 'package:APKExtractorPRO/widgets/custom_alert.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool isSearching = false;
  List<Application> apps = new List<Application>();
  SliverGridDelegate delegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 30.0);

  @override
  void initState() {
    super.initState();
    findApps();
  }

  Future<void> findApps() async {
    var status = Permission.storage;
    var bl = await status.isUndetermined;
    if (bl == true) {
      await status.request();
    }

    if (apps.length == 0) {
      apps = await DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: false,
          onlyAppsWithLaunchIntent: false);

      setState(() {
        isSearching = false;
      });
    }
  }

  generateApk(String path1, String name, MemoryImage img) async {
    // print(path1);
    File f1 = new File(path1); // await UninstallApps
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'ApkExtractor', name);
    Directory n = Directory(path);
    bool dec = await n.exists();
    if (dec == false) {
      await n.create();
    }
    f1.copy('/storage/emulated/0/$name.apk');
    f1.copy(join(path, 'setup.apk'));
    File image = new File(join(path, 'image.jpeg'));
    image.writeAsBytesSync(img.bytes);
    // print(g1.currentWidget);
    setState(() {});
  }

  showOptionsDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        /*FlatButton.icon(
                            icon: Icon(Icons.android),
                            label: Text(
                              "Extract APK",
                              textAlign: TextAlign.left,
                            ),
                            onPressed: () =>
                                generateApk(app.apkFilePath, app.appName, img)),
                        FlatButton.icon(
                            icon: Icon(Icons.share),
                            label: Text("Share APK", textAlign: TextAlign.left),
                            onPressed: () async {
                              ShareIt.file(
                                  path: app.apkFilePath,
                                  type: ShareItFileType.anyFile);
                            }),
                        FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text("Uninistall App",
                                textAlign: TextAlign.left),
                            onPressed: () async {
                              await UninstallApps.uninstall(app.packageName);
                            }),
                        FlatButton.icon(
                            icon: Icon(Icons.info),
                            label: Text("App Info", textAlign: TextAlign.left),
                            onPressed: () async {
                              Navigator.pop(context);
                              showAboutDialog(
                                  context: context,
                                  applicationName: app.appName,
                                  children: [
                                    Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text("Package Name  " +
                                              app.packageName),
                                          Text("Apk Path  " + app.apkFilePath),
                                          Text(
                                              "Data Directory  " + app.dataDir),
                                          Text("Version Name  " +
                                              app.versionName),
                                          Text("Version Code  " +
                                              app.versionCode.toString()),
                                        ]))
                                  ]);
                            }), 
                        FlatButton.icon(
                            icon: Icon(Icons.play_circle_filled),
                            label: Text("Open on Playstore"),
                            onPressed: () async {
                              StoreRedirect.redirect(
                                androidAppId: app.packageName,
                              );
                            }),*/
                      ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${Constants.appName}"),
          elevation: 4,
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: About(),
                  ),
                );
              },
            )
          ],
        ),
        body: isSearching
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: GridView.builder(
                  gridDelegate: delegate,
                  itemCount: apps.length,
                  itemBuilder: (context, index) {
                    Application app = apps[index];
                    return AppItem(app);
                  },
                ),
              ));
  }
}
