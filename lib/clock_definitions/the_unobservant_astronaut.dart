import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class TheUnobservantAstronaut extends ClockDefinition {

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/stars.jpg'),
        size: Size(screen.width * 2, screen.width * 2),
        center: Offset(screen.width / 2, screen.height),
        rotation: Rotation(velocity: -12, unitOfTime: ClockAngle.minute),
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/hour.png'),
        size: Size(screen.width * 1.07, screen.width * 1.07),
        center: Offset(screen.width / 2, screen.height * 0.9),
        rotation: Rotation(unitOfTime: ClockAngle.hour24),
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/rocket.png'),
        size: Size(screen.width * 0.2, screen.width * 0.4),
        center: Offset(screen.width / 2, screen.height * 1.1),
        rotation: Rotation(velocity: -2),
        vectors: [
          Vector(horizontal: screen.height * 0.5, vertical: screen.height * 0.8, velocity: 2)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/saucer.png'),
        size: Size(screen.width * 0.2, screen.width * 0.1),
        center: Offset(screen.width / 2, screen.height * 1.1),
        rotation: Rotation(velocity: 15, pendulumArc: 0.2, pendulumOffset: -0.1),
        vectors: [
          Vector(horizontal: screen.height * 0.5, vertical: screen.height * 0.8, velocity: -2, angularOffset: 0.25)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/halfdial.png'),
        size: Size(screen.width, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(velocity: 0),
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/spacenaut.png'),
        size: Size(screen.height * 0.1, screen.height * 0.1),
        center: Offset(screen.width / 2, screen.height * 0.75),
        rotation: Rotation(velocity: 32),
        vectors: [
          Vector(radius: screen.height / 2.5, velocity: -1, pendulumArc: 0.5, pendulumOffset: 0.25),
          Vector(radius: screen.height / 10, velocity: 11),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/moonnaut.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        rotation: Rotation(velocity: 0),
      ),
    ];
}
