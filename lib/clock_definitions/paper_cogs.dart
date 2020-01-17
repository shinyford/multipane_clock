import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class PaperCogs extends ClockDefinition {

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cogs.jpg'),
        size: Size(screen.width * 1.2, screen.width * 1.2),
        center: Offset(screen.width / 2, screen.height / 2),
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog1.png'),
        size: Size(screen.width * 0.5, screen.width * 0.5),
        center: Offset(0, 0),
        velocity: -1,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog2.png'),
        size: Size(screen.width * 0.5, screen.width * 0.5),
        center: Offset(screen.width, screen.height),
        velocity: -3,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog3.png'),
        size: Size(screen.width * 0.55, screen.width * 0.55),
        center: Offset(screen.width / 3, screen.height / 2),
        velocity: 9,
      ),
      Pane(
        pendulumArc: 0.3,
        image: const AssetImage('assets/images/paper_cogs/cog2.png'),
        size: Size(screen.width * 0.55, screen.width * 0.55),
        center: Offset(screen.width * 2 / 3, screen.height / 2),
        velocity: -6,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog1.png'),
        size: Size(screen.width * 0.6, screen.width * 0.6),
        center: Offset(0, screen.height),
        velocity: 2,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog3.png'),
        size: Size(screen.width * 0.6, screen.width * 0.6),
        center: Offset(screen.width, 0),
        velocity: 5,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/clockface.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        velocity: 0,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/second.png'),
        size: Size(screen.height * 0.9, screen.height * 0.9),
        center: Offset(screen.width / 2, screen.height / 2),
        unitOfTime: ClockAngle.bouncySecond,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/minute.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        unitOfTime: ClockAngle.minute,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/hour.png'),
        size: Size(screen.height, screen.height),
        center: Offset(screen.width / 2, screen.height / 2),
        unitOfTime: ClockAngle.hour,
      ),
      // Pane( // Bouncing hourglass, to demonstrate the use of vectors
      //   image: const AssetImage('assets/images/paper_cogs/hourglass.png'),
      //   size: Size(screen.height * 0.1, //   screen.height * 0.2),
      //   center:  Offset( xInitial: screen.width / 2, //   yInitial: screen.height / 2),
      //   velocity: 24,
      //   vectors: [
      //     Vector(distance: screen.height / 4, velocity: -1),
      //     Vector(distance: screen.height / 6, velocity: 12),
      //   ],
      // ),
    ];
}
