import 'package:APKExtractorPRO/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  final String facebookUrl =
      "https://www.facebook.com/Yazeed-Sabil-Designs-107102297512356/";
  final String twitterUrl = "https://twitter.com/EldeenYazeed";
  final String googleUrl =
      "https://play.google.com/store/apps/developer?id=Yazeed+Sabil";

  Future<void> openUrl(url) async {
    if (await canLaunch(url)) launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Center(
              child: Image.asset("assets/images/launcher/icon.png",
                  height: 130, width: 130),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(Constants.appName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Easily extract APKs from all your apps and games and share them with others!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Text("Created by:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                child: Image.asset(
                  "assets/images/yazeed.png",
                  height: 100,
                  width: 100,
                ),
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 8,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Text("Yazeed Mohi-Eldeen Sabil",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 50),
            Center(
              child: Text("Contact us:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                padding: EdgeInsets.all(5),
                child: IconButton(
                    icon: Icon(MaterialCommunityIcons.facebook),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      openUrl(facebookUrl);
                    }),
              ),
              SizedBox(width: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                padding: EdgeInsets.all(5),
                child: IconButton(
                    icon: Icon(MaterialCommunityIcons.twitter),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      openUrl(twitterUrl);
                    }),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
