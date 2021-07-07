import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memomemo/screens/home_page.dart';
import 'package:rive/rive.dart';

class LaunchPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<LaunchPage> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
          () =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          ),
    );
  }


//
//   void _togglePlay() {
//     setState(() => _controller.isActive = !_controller.isActive);
//   }
//
//   /// Tracks if the animation is playing by whether controller is running.
//   bool get isPlaying => _controller?.isActive ?? false;

  // Artboard _riveArtboard;
  // RiveAnimationController _controller;
  // @override
  // void initState() {
  //
  //   super.initState();
  //
  //   Timer(
  //     Duration(seconds: 1),
  //         () => Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => MyHomePage()),
  //     ),
  //   );

  // Load the animation file from the bundle, note that you could also
  // download this. The RiveFile just expects a list of bytes.
  // rootBundle.load('images/79-313-turtle-sticker.riv').then(
  //       (data) async {
  //     // Load the RiveFile from the binary data.
  //     final file = RiveFile.import(data);
  //     // The artboard is the root of the animation and gets drawn in the
  //     // Rive widget.
  //     final artboard = file.mainArtboard;
  //     // Add a controller to play back a known animation on the main/default
  //     // artboard.We store a reference to it so we can toggle playback.
  //     artboard.addController(_controller = SimpleAnimation('idle'));
  //     setState(() => _riveArtboard = artboard);
  //   },
  // );
  //


// @override
// void initState() {
//   super.initState();
//   Timer(
//     Duration(seconds: 2),
//         () => Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => MyHomePage()),
//     ),
//   );
// }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 10,
          image: AssetImage('images/snoopy2.jpg'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
