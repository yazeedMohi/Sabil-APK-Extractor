import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:loading_animations/loading_animations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:share_it/share_it.dart';

class ExtractingScreen extends StatefulWidget {
  ExtractingScreen(this.path, this.name, this.img);
  final String path;
  final String name;
  final Uint8List img;

  @override
  State<StatefulWidget> createState() {
    return ExtractState();
  }
}

class ExtractState extends State<ExtractingScreen> {
  bool done = false;
  @override
  void initState() {
    super.initState();
    copyFile();
    /*
    File f1 = new File(widget.path);
    var x = f1.copy('/storage/emulated/0/$widget.name.apk');
    x.then((value) => null);*/
  }

  Directory destinationPath;

  void copyFile() async {
    destinationPath = await getExternalStorageDirectory();

    String path = join(destinationPath.path, widget.name + ".apk");

    print("copying file from ${widget.path} to $path");
    File f1 = new File(widget.path);
    f1.copy(path).then((value) => setState(() {
          print("COPY DONE");
          done = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: done
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.memory(widget.img),
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      widget.name + " Extracted Successfully",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Text(
                      "Location: " +
                          join(destinationPath.path, widget.name + ".apk"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  FlatButton.icon(
                      icon: Icon(Icons.share),
                      label: Text("Share", textAlign: TextAlign.left),
                      onPressed: () async {
                        ShareIt.file(
                            path: widget.path, type: ShareItFileType.anyFile);
                      }),
                  SizedBox(height: 10),
                  FlatButton.icon(
                      icon: Icon(Icons.arrow_back),
                      label: Text("Back", textAlign: TextAlign.left),
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*Bubble(
              duration: Duration(seconds: 5),
            ),*/
                  LoadingBouncingGrid.square(
                    backgroundColor: Colors.cyan,
                    borderColor: Colors.cyanAccent,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "Extracting ${widget.name}...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
