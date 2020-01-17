import 'package:flutter/widgets.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

import 'package:multipane_clock/multipane_clock.dart';

class FlutskyOrloj extends ClockDefinition {
  Location _prague;

  FlutskyOrloj() {
    initializeTimeZones();
    _prague = getLocation('Europe/Prague');
  }

  @override
  DateTime get now => TZDateTime.now(_prague);

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/stars.jpg'),
        size: Size(screen.width * 1.2, screen.width * 1.2),
        center: Offset(screen.width / 2, screen.height / 2),
        velocity: 6,
        unitOfTime: ClockAngle.minute,
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/main_dial.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        velocity: 0,
      ),
      Pane(
        pendulumArc: 0.217,
        pendulumOffset: -0.085,
        angularOffset: 0.55,
        image: const AssetImage('assets/images/flutsky_orloj/old_czech.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        // clockAngle: ClockAngle.dayOfYear,
        velocity: 15,
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/time_hand.png'),
        size: Size(screen.height * 0.85, screen.height * 0.85),
        center: Offset(screen.width / 2, screen.height / 2),
        unitOfTime: ClockAngle.hour24
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/small_dial.png'),
        size: Size(screen.height / 1.42, screen.height / 1.42),
        center: Offset(screen.width / 2, screen.height / 2),
        unitOfTime: ClockAngle.siderialDay,
        vectors: [
          Vector(distance: screen.height / -8.8, velocity: -1, unitOfTime: ClockAngle.siderialDay),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/sun.png'),
        size: Size(screen.height / 8, screen.height / 8),
        center: Offset(screen.width / 2, screen.height / 2),
        vectors: [
          Vector(distance: screen.height / -8.8, velocity: -1, unitOfTime: ClockAngle.siderialDay),
          Vector(distance: screen.height / -3.9, velocity: 1, unitOfTime: ClockAngle.dayOfYear),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/moon.png'),
        size: Size(screen.height / 8, screen.height / 8),
        center: Offset(screen.width / 2, screen.height / 2),
        velocity: 0,
        vectors: [
          Vector(distance: screen.height / -8.8, velocity: -1, unitOfTime: ClockAngle.siderialDay),
          Vector(distance: screen.height / -3.9, velocity: 1, unitOfTime: ClockAngle.lunarDay),
        ]
      ),
    ];
}
