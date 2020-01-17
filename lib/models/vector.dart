import 'dart:math' as Math;

import 'package:flutter/widgets.dart';
import 'package:multipane_clock/multipane_clock.dart';

class Vector {
  static const double _MINUS_TWO_PI = Math.pi * -2;
  static const double _PI_BY_TWO = Math.pi / 2;

  final ClockAngle clockAngle;
  final double angularOffset;
  final double distance;
  final int velocity;

  Vector({
    ClockAngle unitOfTime,
    this.angularOffset = 0,
    this.distance = 0,
    this.velocity = 1,
  }) : this.clockAngle = unitOfTime ?? ClockAngle.second;

  double angleFor(DateTime time) =>
      (clockAngle.at(time) + angularOffset) * velocity;

  Offset offsetFor(double angle) =>
      Offset.fromDirection(angle * _MINUS_TWO_PI + _PI_BY_TWO, distance);
}
