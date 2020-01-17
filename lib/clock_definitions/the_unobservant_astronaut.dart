import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class TheUnobservantAstronaut extends ClockDefinition {
  final ClockAngle threeMinutes =
      ClockAngle(calculator: AngleCalculator(period: Duration(minutes: 3)));

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/stars.jpg'),
        size: Size(screen.width * 2, screen.width * 2),
        center: Offset(screen.width / 2, screen.height),
        velocity: -12,
        unitOfTime: ClockAngle.minute,
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/hour.png'),
        size: Size(screen.width * 1.07, screen.width * 1.07),
        center: Offset(screen.width / 2, screen.height * 0.9),
        unitOfTime: ClockAngle.hour24
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/rocket.png'),
        size: Size(screen.width * 0.2, screen.width * 0.4),
        center: Offset(screen.width / 2, screen.height * 0.75),
        velocity: -6, // -2 * 3
        showTo: 1 / 6,
        unitOfTime: threeMinutes,
        vectors: [
          Vector(distance: screen.height / 2, velocity: 2)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/rocket.png'),
        size: Size(screen.width * 0.2, screen.width * 0.4),
        center: Offset(screen.width / 2, screen.height * 0.75),
        velocity: 6, // -2 * 3
        showFrom: 3 / 6,
        showTo: 4 / 6,
        unitOfTime: threeMinutes,
        angularOffset: 0.25,
        vectors: [
          Vector(distance: screen.height / 2, velocity: -2)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/saucer.png'),
        size: Size(screen.width * 0.2, screen.width * 0.1),
        center: Offset(screen.width / 2, screen.height * 0.75),
        velocity: 45, // 15 * 3
        pendulumArc: 0.2,
        pendulumOffset: -0.1,
        showFrom: 1 / 6,
        showTo: 2 / 6,
        unitOfTime: threeMinutes,
        vectors: [
          Vector(distance: screen.height / 2, velocity: -2, angularOffset: 0.5)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/saucer.png'),
        size: Size(screen.width * 0.2, screen.width * 0.1),
        center: Offset(screen.width / 2, screen.height * 0.75),
        velocity: -45, // 15 * 3
        pendulumArc: 0.2,
        pendulumOffset: -0.1,
        showFrom: 4 / 6,
        showTo: 5 / 6,
        unitOfTime: threeMinutes,
        vectors: [
          Vector(distance: screen.height / 2, velocity: 2, angularOffset: 0.5)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/spacenaut.png'),
        size: Size(screen.width * 0.1, screen.width * 0.1),
        center: Offset(screen.width / 2, screen.height * 0.75),
        velocity: 45,
        showFrom: 2 / 6,
        showTo: 3 / 6,
        unitOfTime: threeMinutes,
        vectors: [
          Vector(distance: screen.height / 2, velocity: 2),
          Vector(distance: screen.height / 12, velocity: 24),
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/spacenaut.png'),
        size: Size(screen.width * 0.1, screen.width * 0.1),
        center: Offset(screen.width / 2, screen.height * 0.75),
        velocity: -45,
        showFrom: 5 / 6,
        unitOfTime: threeMinutes,
        vectors: [
          Vector(distance: screen.height / 2, velocity: -2),
          Vector(distance: screen.height / 12, velocity: -24),
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/halfdial.png'),
        size: Size(screen.width, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        velocity: 0,
      ),
      // Pane(
      //   image: const AssetImage('assets/images/unobservant_astronaut/spacenaut.png'),
      //   size: Size(screen.height * 0.1, screen.height * 0.1),
      //   center: Offset(screen.width / 2, screen.height / 2.5),
      //   velocity: 32,
      //   vectors: [
      //     Vector(distance: screen.height / 3, velocity: -1),
      //     Vector(distance: screen.height / 10, velocity: 11),
      //   ]
      // ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/moonnaut.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        velocity: 0,
      ),
    ];
}
