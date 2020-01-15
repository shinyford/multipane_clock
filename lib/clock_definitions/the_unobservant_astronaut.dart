import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class TheUnobservantAstronaut extends ClockDefinition {

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/stars.jpg'),
        width: screen.width * 2,
        height: screen.width * 2,
        cx: screen.width / 2,
        cy: screen.height,
        velocity: -12,
        unitOfTime: UnitOfTime.minute,
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/hour.png'),
        width: screen.width * 1.07,
        height: screen.width * 1.07,
        cx: screen.width / 2,
        cy: screen.height * 0.9,
        unitOfTime: UnitOfTime.hour24
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/rocket.png'),
        width: screen.width * 0.2,
        height: screen.width * 0.4,
        cx: screen.width / 2,
        cy: screen.height * 0.6,
        velocity: -2,
        showTo: 0.5,
        vectors: [
          Vector(distance: screen.height / 2, velocity: 2)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/saucer.png'),
        width: screen.width * 0.2,
        height: screen.width * 0.1,
        cx: screen.width / 2,
        cy: screen.height * 0.6,
        velocity: 15,
        pendulumArc: 0.2,
        pendulumOffset: -0.1,
        showFrom: 0.5,
        vectors: [
          Vector(distance: screen.height / 2, velocity: -2, angularOffset: 0.5)
        ],
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/halfdial.png'),
        width: screen.width,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        velocity: 0,
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/spacenaut.png'),
        width: screen.height * 0.1,
        height: screen.height * 0.1,
        cx: screen.width / 2,
        cy: screen.height / 2.5,
        velocity: 32,
        vectors: [
          Vector(distance: screen.height / 3, velocity: -1),
          Vector(distance: screen.height / 10, velocity: 11),
        ]
      ),
      Pane(
        image: const AssetImage('assets/images/unobservant_astronaut/moonnaut.png'),
        width: screen.height,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        velocity: 0,
      ),
    ];
}
