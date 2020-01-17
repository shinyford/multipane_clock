import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';


class PaneWidget extends StatelessWidget {
  static const double _TWO_PI = Math.pi * 2;

  final DateTime time;
  final Pane pane;

  PaneWidget({Key key, this.time, this.pane}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Offset panePosition = pane.positionAt(time);
    return Positioned(
      top: panePosition.dy,
      left: panePosition.dx,
      child: pane.isRotating ? _rotatedPane : pane.image,
    );
  }

  Widget get _rotatedPane =>
    Transform.rotate(
      angle: pane.angleAt(time) * _TWO_PI,
      child: pane.image,
    );
}
