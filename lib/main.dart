import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:multipane_clock/multipane_clock.dart';

void main() => runApp(MultipaneClockApp());

class MultipaneClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // fix to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // hide status bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Multipane Clock',
      home: Center(
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: MulticlockWidget(
            faceTime: Duration(seconds: 20),
            faces: [
              PaperCogs(),
              TheUnobservantAstronaut(),
              FlutskyOrloj(),
            ]
          ),
        ),
      )
    );
  }
}
