import 'dart:math' as Math;

import 'package:flutter/widgets.dart';
import 'package:multipane_clock/multipane_clock.dart';

/*
 * `Vector`
 *
 * A representation of an offset from a current position, comprising a distance and an angle
 * calculated from a `DateTime` instance.
 *
 * `ClockAngle clockAngle`: the time unit to use to calculate the angle, according to the current time
 * `double angularOffset`: the amount to add to the current angle before applying a velocity, allowing
 * a time to effectively look like its future or past by some degree. This is used, * for example, in
 * the Fluttsky Orloj, where the start of a pendulum curve for one dial needs to align to Dec 21 rather
 * than Jan 1, the default.
 * `double radius`: the radius of the circle made by the vector; its distance
 * `double horizontal`, `double vertical`: the horizontal and vertical radii when the vector describes
 * an ellipse rather than a perfect circle.
 * `double pendulumArc`: the portion of a circle covered by a vector, if not full
 * `double pendulumOffset`: where the pendulum arc starts around a circle
 */
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

  double angleAt(DateTime time) {
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

/*
 * `Rotation`
 *
 * A specialisation of a `Vector`, with zero radius.
 */
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
