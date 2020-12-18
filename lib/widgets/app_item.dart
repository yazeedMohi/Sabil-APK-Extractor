import 'dart:io';
import 'dart:typed_data';

import 'package:APKExtractorPRO/screens/extracting_screen.dart';
import 'package:APKExtractorPRO/widgets/custom_alert.dart';
import 'package:device_apps/device_apps.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_it/share_it.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:uninstall_apps/uninstall_apps.dart';

// ignore: must_be_immutable
class AppItem extends StatelessWidget {
  ApplicationWithIcon app;

  Application afd;
  AppItem(this.app);

  generateApk(
      BuildContext context, String path1, String name, Uint8List img) async {
    print("here");
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: ExtractingScreen(path1, name, img),
      ),
    );
    // print(path1);
    //File f1 = new File(path1); // await UninstallApps

    /*Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'ApkExtractor', name);
    Directory n = Directory(path);
    bool dec = await n.exists();
    if (dec == false) {
      await n.create();
    }*/
    //f1.copy('/storage/emulated/0/$name.apk');
    //f1.copy(join(path, 'setup.apk'));
    //File image = new File(join(path, 'image.jpeg'));
    //image.writeAsBytesSync(img.bytes);
    // print(g1.currentWidget);
  }

  showInfoDialog(context, app, img) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Container(
                          child: Image.memory(img),
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(height: 15),
                        Text(
                          app.appName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Package Name:",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "    " + app.packageName,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Version Name:",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "    " + app.versionName,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Version Code:",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "    " + app.versionCode.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Data Directory:",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "    " + app.dataDir,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Size:",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "    " +
                                filesize(File(app.apkFilePath).lengthSync()),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 15),
                      ])));
        });
/*context: context,
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
                                  ]);*/
  }

  showOptionsDialog(context, app, img) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //SizedBox(height: 20),
                        FlatButton.icon(
                            icon: Icon(Icons.android),
                            label: Text(
                              "Extract APK",
                              textAlign: TextAlign.left,
                            ),
                            onPressed: () => generateApk(
                                context, app.apkFilePath, app.appName, img)),
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
                              showInfoDialog(context, app, img);
                            }),
                        FlatButton.icon(
                            icon: Icon(Icons.play_circle_filled),
                            label: Text("Open on Playstore"),
                            onPressed: () async {
                              StoreRedirect.redirect(
                                androidAppId: app.packageName,
                              );
                            }),
                      ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      /*header: CircleAvatar(
          backgroundImage: MemoryImage(app.icon),
        ),*/
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(bottom: 0, top: 0, left: 5, right: 5),
          child: Column(
            children: [
              app is ApplicationWithIcon
                  ? Container(
                      child: Image.memory(app.icon), height: 50, width: 50)
                  /*
                      radius: 30,
                      backgroundColor: Colors.transparent,
                    )*/
                  : CircleAvatar(),
              SizedBox(
                height: 10,
              ),
              Text(
                "${app.appName}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "[${app.versionName}]",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 1,
              )
            ],
          ),
        ),
        onTap: () {
          showOptionsDialog(
              context, app, app is ApplicationWithIcon ? app.icon : null);
        },
      ),
      //footer: Text("${app.appName}\n${app.versionName}")
    );
  }
}
