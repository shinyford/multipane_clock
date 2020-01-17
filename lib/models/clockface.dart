import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

/*
 * `ClockFace`
 *
 * An abstract class for clock face definition.
 */
abstract class Clockface {
  Iterable<Pane> generate(Rect screen);
  DateTime get time => DateTime.now();
}
