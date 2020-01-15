import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class PaperCogs extends ClockDefinition {

  @override
  Iterable<Pane> generate(Rect screen) =>
    [
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cogs.jpg'),
        width: screen.width * 1.2,
        height: screen.width * 1.2,
        cx: screen.width / 2,
        cy: screen.height / 2,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog1.png'),
        width: screen.width * 0.5,
        height: screen.width * 0.5,
        cx: 0,
        cy: 0,
        velocity: -1,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog2.png'),
        width: screen.width * 0.5,
        height: screen.width * 0.5,
        cx: screen.width,
        cy: screen.height,
        velocity: -3,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog3.png'),
        width: screen.width * 0.55,
        height: screen.width * 0.55,
        cx: screen.width / 3,
        cy: screen.height / 2,
        velocity: 3,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog2.png'),
        width: screen.width * 0.55,
        height: screen.width * 0.55,
        cx: screen.width * 2 / 3,
        cy: screen.height / 2,
        velocity: -4,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog1.png'),
        width: screen.width * 0.6,
        height: screen.width * 0.6,
        cx: 0,
        cy: screen.height,
        velocity: 2,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/cog3.png'),
        width: screen.width * 0.6,
        height: screen.width * 0.6,
        cx: screen.width,
        cy: 0,
        velocity: 5,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/clockface.png'),
        width: screen.height,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        velocity: 0,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/second.png'),
        width: screen.height * 0.9,
        height: screen.height * 0.9,
        cx: screen.width / 2,
        cy: screen.height / 2,
        unitOfTime: UnitOfTime.bouncySecond,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/minute.png'),
        width: screen.height,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        unitOfTime: UnitOfTime.minute,
      ),
      Pane(
        image: const AssetImage('assets/images/paper_cogs/hour.png'),
        width: screen.height,
        height: screen.height,
        cx: screen.width / 2,
        cy: screen.height / 2,
        unitOfTime: UnitOfTime.hour,
      ),
      // Pane( // Bouncing hourglass, to demonstrate the use of vectors
      //   image: const AssetImage('assets/images/paper_cogs/hourglass.png'),
      //   width: screen.height * 0.1,
      //   height: screen.height * 0.2,
      //   xInitial: screen.width / 2,
      //   yInitial: screen.height / 2,
      //   velocity: 24,
      //   vectors: [
      //     Vector(distance: screen.height / 4, velocity: -1),
      //     Vector(distance: screen.height / 6, velocity: 12),
      //   ],
      // ),
    ];
}
