import 'dart:math' as Math;

import 'package:flutter/widgets.dart';
import 'package:multipane_clock/multipane_clock.dart';

class Vector {
  static const double _TWO_PI = Math.pi * 2;

  final ClockAngle clockAngle;
  final double angularOffset;
  final double vertical;
  final double horizontal;
  final double velocity;
  final double pendulumArc;
  final double pendulumOffset;

  Vector({
    ClockAngle unitOfTime,
    this.angularOffset = 0,
    this.velocity = 1,
    this.pendulumArc,
    this.pendulumOffset = 0,
    double radius = 0,
    double vertical,
    double horizontal,
  }) :
    this.clockAngle = unitOfTime ?? ClockAngle.second,
    this.vertical = vertical ?? radius,
    this.horizontal = horizontal ?? radius;

  double angleFor(DateTime time) {
    double angle = (clockAngle.at(time) + angularOffset) * velocity;

    if (pendulumArc is double) {
      angle = angle - angle.truncateToDouble();
      if (angle.isNegative) angle = 1 + angle;
      if (angle > 0.5) angle = 1 - angle; // create a pendulum effect
      angle = Curves.easeInOutSine.transform(angle * 2);
      angle = pendulumOffset + angle * pendulumArc;
    }

    return angle;
  }

  Offset offsetFor(double angle) =>
    Offset(
      Math.sin(angle * _TWO_PI) * horizontal,
      Math.cos(angle * _TWO_PI) * vertical
    );
}

class Rotation extends Vector {
  Rotation({
    double velocity = 1,
    ClockAngle unitOfTime,
    double angularOffset = 0,
    double pendulumArc,
    double pendulumOffset = 0,
  }) : super(
    unitOfTime: unitOfTime,
    angularOffset: angularOffset,
    velocity: velocity,
    pendulumArc: pendulumArc,
    pendulumOffset: pendulumOffset,
  );

  @override
  Offset offsetFor(double _) => Offset.zero;
}
