import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

abstract class ClockDefinition {
  DateTime get now => DateTime.now();
  Iterable<Pane> generate(Rect screen);
}
