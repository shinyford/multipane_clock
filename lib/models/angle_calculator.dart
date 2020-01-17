// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

/*
 * `AngleCalculator`
 *
 * A calculator for the proportion of a `period` that has passed at a given `DateTime` instant
 * using what is effectively floating point clock arithmetic (no pun intended).
 *
 * `Duration period`: the period in question
 * `double adjustment`: an adjustment to the resultant proportion that has passed, to allow for the fact
 * that the Epoch against which it's checked does not necessarily lie on the `period`'s boundary.
 */
class AngleCalculator {
  final Duration period;
  final double adjustment;

  AngleCalculator({@required this.period, this.adjustment = 0});

  double calculation(DateTime time) {
    final double angle = (time.millisecondsSinceEpoch / period.inMilliseconds) + adjustment;
    return angle - angle.truncateToDouble(); // we're only interested in the fractional component
  }
}
