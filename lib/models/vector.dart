import 'dart:math' as Math;

import 'package:multipane_clock/multipane_clock.dart';

class Vector {
  final UnitOfTime unitOfTime;
  final double angularOffset;
  final double distance;
  final int velocity;

  Vector({
    this.unitOfTime = UnitOfTime.second,
    this.angularOffset = 0,
    this.distance = 0,
    this.velocity = 1,
  });

  double angleFor(AngularClockTime dateTime) =>
      (dateTime.angleFor(unitOfTime) + angularOffset) * velocity;

  double xOffsetFor(double angle) => Math.sin(angle) * distance;

  double yOffsetFor(double angle) => Math.cos(angle) * distance;
}
