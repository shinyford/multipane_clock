import 'package:flutter/widgets.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';

import 'package:multipane_clock/multipane_clock.dart';

class FlutskyOrloj extends ClockDefinition {
  Location _pragueTZ;

  FlutskyOrloj() {
    initializeTimeZones();
    _pragueTZ = getLocation('Europe/Prague');
  }

  @override
  DateTime get now => TZDateTime.now(_pragueTZ);
  // DateTime get now => TZDateTime(_pragueTZ, 2020, 12, 20, 16, 03);
  // DateTime get now => TZDateTime(_pragueTZ, 2020, 6, 21, 21, 15);
  // DateTime get now => TZDateTime(_pragueTZ, 2020, 3, 21, 18, 25);
  // DateTime get now => TZDateTime(_pragueTZ, 2020, 9, 21, 18, 16);

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/stars.jpg'),
        width: screen.width * 1.2,
        height: screen.width * 1.2,
        cx: screen.width / 2,
        cy: screen.height / 2,
        velocity: 6,
        unitOfTime: UnitOfTime.minute,
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/main_dial.png'),
        width: screen.height,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        velocity: 0,
      ),
      Pane(
        pendulumArc: 0.217,
        pendulumOffset: -0.085,
        angularOffset: 0.55,
        image: const AssetImage('assets/images/flutsky_orloj/old_czech.png'),
        width: screen.height,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        // unitOfTime: UnitOfTime.dayOfYear
        velocity: 15
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/time_hand.png'),
        width: screen.height * 0.85,
        height: screen.height * 0.85,
        cx: screen.width / 2,
        cy: screen.height / 2,
        unitOfTime: UnitOfTime.hour24
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/small_dial.png'),
        width: screen.height / 1.42,
        height: screen.height / 1.42,
        cx: screen.width / 2,
        cy: screen.height / 2,
        unitOfTime: UnitOfTime.siderialDay,
        vectors: [
          Vector(distance: screen.height / -8.8, velocity: -1, unitOfTime: UnitOfTime.siderialDay),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/sun.png'),
        width: screen.height / 8,
        height: screen.height / 8,
        cx: screen.width / 2,
        cy: screen.height / 2,
        vectors: [
          Vector(distance: screen.height / -8.8, velocity: -1, unitOfTime: UnitOfTime.siderialDay),
          Vector(distance: screen.height / -3.9, velocity: 1, unitOfTime: UnitOfTime.dayOfYear),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/flutsky_orloj/moon.png'),
        width: screen.height / 8,
        height: screen.height / 8,
        cx: screen.width / 2,
        cy: screen.height / 2,
        velocity: 0,
        vectors: [
          Vector(distance: screen.height / -8.8, velocity: -1, unitOfTime: UnitOfTime.siderialDay),
          Vector(distance: screen.height / -3.9, velocity: 1, unitOfTime: UnitOfTime.lunarDay),
        ]
      ),
    ];
}
