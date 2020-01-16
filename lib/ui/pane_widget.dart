import 'dart:math' as Math;

import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';


class PaneWidget extends StatelessWidget {
  static const double _TWO_PI = Math.pi * 2;

  final AngularClockTime time;
  final Pane pane;

  PaneWidget({Key key, this.time, this.pane}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Offset panePosition = _panePosition();
    return Positioned(
      top: panePosition.dy,
      left: panePosition.dx,
      child: pane.isRotating ? _rotatedPane : pane.image,
    );
  }

  Widget get _rotatedPane =>
    Transform.rotate(
      angle: pane.angleFor(time) * _TWO_PI,
      child: pane.image,
    );

  Offset _panePosition() {
    Offset position = pane.position;

    if (pane.isOffset) {
      double cumulativeAngle = 0;

      for (Vector vector in pane.vectors) {
        cumulativeAngle += vector.angleFor(time);
        position += vector.offsetFor(cumulativeAngle);
      }
    }

    return position;
  }
}
