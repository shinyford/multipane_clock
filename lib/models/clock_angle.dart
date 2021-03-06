// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:flutter/animation.dart';
import 'package:multipane_clock/multipane_clock.dart';

typedef AngleFunction = double Function(DateTime time);

/*
 * `ClockAngle`
 *
 * A container for a function that will return an angle for a given `DateTime` instant
 * to answer the question: what proportion of a given period of time has passed at a
 * particular `DateTime` point in time? More simply: if I were a hand on a clock, how
 * much of the clock face would I have traversed? What would I be pointing at?
 *
 * Static instances are provided for commonly needed angles: `second`, `minute`, `hour`
 * etc. More esoteric `ClockAngle`s for siderial day, lunar day and day of year are also
 * available.
 *
 * Some 'bouncy' instances are also provided, giving a delayed change in angle to mimic
 * the movement of watch hands and e.g. am/pm discs.
 */
class ClockAngle {
  static const List<int> _DAYS_BEFORE = [0, -1, 30, 58, 89, 119, 150, 180, 211, 242, 272, 303, 333];

  final AngleFunction at;

  ClockAngle({AngleCalculator calculator, AngleFunction function}) : this.at = function ?? calculator.calculation;

  static ClockAngle millisecond = ClockAngle(
    function: (DateTime time) => time.millisecond / 1000.0,
  );
  static ClockAngle second = ClockAngle(
    function: (DateTime time) => (time.second + ClockAngle.millisecond.at(time)) / 60.0,
  );
  static ClockAngle minute = ClockAngle(
    function: (DateTime time) => (time.minute + ClockAngle.second.at(time)) / 60.0,
  );
  static ClockAngle hour = ClockAngle(
    function: (DateTime time) => ((time.hour % 12) + ClockAngle.minute.at(time)) / 12.0,
  );
  static ClockAngle hour24 = ClockAngle(
    function: (DateTime time) => (time.hour + ClockAngle.minute.at(time)) / 24.0,
  );
  static ClockAngle meridien = ClockAngle(
    function: (DateTime time) => ((time.hour > 11 ? 1 : 0) + ClockAngle.hour.at(time)) / 2.0,
  );
  static ClockAngle day = ClockAngle(
    function: (DateTime time) => ((time.day - 1) + ClockAngle.meridien.at(time)) / 31.0, // TODO fix visual weirdness when going from e.g. 28 Feb to 1 Mar
  );

  static ClockAngle bouncySecond = ClockAngle(
    function: (DateTime time) => (time.second + _dampedFinalRamp(ClockAngle.millisecond.at(time), rampFrom: 0.25)) / 60.0, // dramp after initial quarter of each second
  );
  static ClockAngle bouncyMeridien = ClockAngle(
    function: (DateTime time) => ((time.hour > 11 ? 1 : 0) + _finalRamp(ClockAngle.hour.at(time), rampFrom: 719 / 720)) / 2.0, // ramp for the last minute of a meridien
  );
  static ClockAngle bouncyDay = ClockAngle(
    function: (DateTime time) => ((time.day - 1) + _finalRamp(ClockAngle.hour24.at(time), rampFrom: 1439 / 1440)) / 31.0, // ramp for the last minute of a day
  );

  static ClockAngle siderialDay = ClockAngle(
    calculator: AngleCalculator(
      period: const Duration(hours: 23, minutes: 56, seconds: 4, milliseconds: 100), // siderial day: 23°56'04.1"
      adjustment:  0.07, // adjustment angle needed to push the siderial day to the right orientation
    ),
  );
  static ClockAngle lunarDay = ClockAngle(
    calculator: AngleCalculator(
      period: const Duration(days: 29, hours: 12, minutes: 44, seconds: 3), // lunar day: 29.53d
      adjustment:  0.41, // adjustment angle needed to push the lunar day to the right orientation
    ),
  );
  static ClockAngle dayOfYear = ClockAngle(
    function: (DateTime time) {
      double day = _DAYS_BEFORE[time.month] + time.day + ClockAngle.hour24.at(time);
      if (time.year % 4 == 0) { // leap year
        if (time.month > 2) day += 1;
        return day / 366;
      }
      return day / 365;
    }
  );

  // keeps the value at zero until a sudden ramp up right at the end.
  static double _finalRamp(double t, {double rampFrom}) {
    if (t < rampFrom) return 0;
    return (t - rampFrom) / (1 - rampFrom);
  }

  // as with `_finalRamp`, but with a damped effect on the ramp
  // to create a nice, clunky, mechanical bounce as of a second hand.
  static double _dampedFinalRamp(double t, {double rampFrom}) =>
      Curves.bounceOut.transform(_finalRamp(t, rampFrom: rampFrom));
}
