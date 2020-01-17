import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class Pane {
  final Iterable<Vector> vectors;
  final ClockAngle clockAngle;
  final int velocity;
  final Offset position;
  final double angularOffset;
  final double pendulumArc;
  final double pendulumOffset;
  final double showFrom;
  final double showTo;
  final Image image;

  Pane({
    this.vectors,
    this.velocity = 1,
    this.angularOffset = 0,
    this.pendulumArc,
    this.pendulumOffset = 0,
    this.showFrom = 0,
    this.showTo = 1,
    ClockAngle unitOfTime,
    @required AssetImage image,
    @required Size size,
    @required Offset center,
  }) :
    this.clockAngle = unitOfTime ?? ClockAngle.second,
    this.image = Image(image: image, width: size.width, height: size.height),
    this.position = center - size.center(Offset.zero);

  bool get isRotating => velocity != 0;

  bool shouldShowFor(DateTime time) {
    final double angle = clockAngle.at(time);
    return angle >= showFrom && angle <= showTo;
  }

  double angleFor(DateTime time) {
    double angle = (clockAngle.at(time) + angularOffset) * velocity;

    if (pendulumArc is double) {
      angle = (angle - angle.truncateToDouble()).clamp(-1.0, 1.0);
      if (angle.isNegative) angle = 1 + angle;
      if (angle > 0.5) angle = 1 - angle; // create a pendulum effect
      angle = Curves.easeInOutSine.transform(angle * 2);
      angle = pendulumOffset + angle * pendulumArc;
    }

    return angle;
  }

  Offset positionAt(DateTime time) {
    Offset position = this.position;

    if (vectors is Iterable) {
      double cumulativeAngle = 0;

      for (Vector vector in vectors) {
        cumulativeAngle += vector.angleFor(time);
        position += vector.offsetFor(cumulativeAngle);
      }
    }

    return position;
  }
}
