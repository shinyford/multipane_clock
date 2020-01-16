import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class Pane {
  final Iterable<Vector> vectors;
  final UnitOfTime unitOfTime;
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
    this.unitOfTime = UnitOfTime.second,
    this.velocity = 1,
    this.angularOffset = 0,
    this.pendulumArc,
    this.pendulumOffset = 0,
    this.showFrom = 0,
    this.showTo = 1,
    @required AssetImage image,
    @required Size size,
    @required Offset center,
  }) :
    this.image = Image(image: image, width: size.width, height: size.height),
    this.position = center - size.center(Offset.zero);

  bool get isOffset => vectors is Iterable;
  bool get isRotating => velocity != 0;

  bool shouldShowFor(AngularClockTime time) {
    final double angle = time.angleFor(unitOfTime);
    return angle >= showFrom && angle <= showTo;
  }

  double angleFor(AngularClockTime time) {
    double angle = (time.angleFor(unitOfTime) + angularOffset) * velocity;

    if (pendulumArc is double) {
      angle = (angle - angle.truncateToDouble()).clamp(-1.0, 1.0);
      if (angle.isNegative) angle = 1 + angle;
      if (angle > 0.5) angle = 1 - angle; // create a pendulum effect
      angle = Curves.easeInOutSine.transform(angle * 2);
      angle = pendulumOffset + angle * pendulumArc;
    }

    return angle;
  }
}
