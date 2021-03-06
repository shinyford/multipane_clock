// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

import 'package:multipane_clock/multipane_clock.dart';

/*
 * `Flutsky Orloj`
 *
 * A simulation of the Pražský Orloj astronomical clock in Prague.
 *
 * Note that this clockface is fixed to Prague time.
 */
class FlutskyOrloj extends Clockface {
  Location _prague;

  FlutskyOrloj() {
    initializeTimeZones();
    _prague = getLocation('Europe/Prague');
  }

  @override
  DateTime get time => TZDateTime.now(_prague);

  @override
  Iterable<Pane> createPanesFor(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/stars.jpg'),
        size: Size(screen.width * 1.2, screen.width * 1.2),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(velocity: 6, unitOfTime: ClockAngle.minute),
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/main_dial.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(velocity: 0),
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/old_czech.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(velocity: 15, pendulumArc: 0.217, pendulumOffset: -0.085, angularOffset: 0.55),
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/time_hand.png'),
        size: Size(screen.height * 0.85, screen.height * 0.85),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(unitOfTime: ClockAngle.hour24),
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/small_dial.png'),
        size: Size(screen.height / 1.42, screen.height / 1.42),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(unitOfTime: ClockAngle.siderialDay),
        vectors: [
          Vector(radius: screen.height / -8.8, velocity: -1, unitOfTime: ClockAngle.siderialDay),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/sun.png'),
        size: Size(screen.height / 8, screen.height / 8),
        center: Offset(screen.width / 2, screen.height / 2),
        vectors: [
          Vector(radius: screen.height / -8.8, velocity: -1, unitOfTime: ClockAngle.siderialDay),
          Vector(radius: screen.height / -3.9, velocity: 1, unitOfTime: ClockAngle.dayOfYear, angularOffset: 0.51),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/moon.png'),
        size: Size(screen.height / 8, screen.height / 8),
        center: Offset(screen.width / 2, screen.height / 2),
        vectors: [
          Vector(radius: screen.height / -8.8, velocity: -1, unitOfTime: ClockAngle.siderialDay),
          Vector(radius: screen.height / -3.9, velocity: 1, unitOfTime: ClockAngle.lunarDay),
        ]
      ),
    ];
}
