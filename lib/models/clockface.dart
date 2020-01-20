// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

/*
 * `ClockFace`
 *
 * An abstract class for clock face definition.
 */
abstract class Clockface {
  Iterable<Pane> createPanesFor(Rect screen);
  DateTime get time => DateTime.now();
}
