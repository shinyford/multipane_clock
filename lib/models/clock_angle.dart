import 'package:flutter/animation.dart';
import 'package:multipane_clock/multipane_clock.dart';

typedef AngleFunction = double Function(DateTime time);

/*
 * `ClockAngle`
 *
 * A container for a function that will return an angle for a given `DateTime` instant
 * to answer the question: if I were a hand on a clock, what angle would I point at?
 *
 * This makes it a bit anti-intuitive, since hands for a given time unit take the next higher
 * unit's worth of time to go round a clock: a second hand takes a minute; a minute hand takes
 * an hour; an hour hand takes a meridien; and so on, at least conceptually.
 *
 * Most `ClockAngle`s will simply wrap an `AngleCalculator`. Some, notably the bouncy timings,
 * slightly different methods.
 */
class ClockAngle {
  final AngleFunction at;

  ClockAngle({AngleCalculator calculator, AngleFunction function}) : this.at = function ?? calculator.calculation;

  static ClockAngle millisecond = ClockAngle(
    function: (DateTime time) => time.millisecond / 1000.0,
  );
  static ClockAngle second = ClockAngle(
    calculator: AngleCalculator(period: Duration(minutes: 1)),
  );
  static ClockAngle minute = ClockAngle(
    calculator: AngleCalculator(period: Duration(hours: 1)),
  );
  static ClockAngle hour = ClockAngle(
    calculator: AngleCalculator(period: Duration(hours: 12)),
  );
  static ClockAngle hour24 = ClockAngle(
    calculator: AngleCalculator(period: Duration(days: 1)),
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
      period: Duration(hours: 23, minutes: 56, seconds: 4, milliseconds: 100), // siderial day in ms: 23°56'04.1"
      adjustment:  0.07, // adjustment angle needed to push the siderial day to the right orientation
    ),
  );
  static ClockAngle lunarDay = ClockAngle(
    calculator: AngleCalculator(
      period: Duration(milliseconds: 2953 * 24 * 60 * 60 * 10), // lunar day in ms: 29.53d
      adjustment:  0.39, // adjustment angle needed to push the lunar day to the right orientation
    ),
  );
  static ClockAngle dayOfYear = ClockAngle(
    function: (DateTime time) {
      const List<int> months = [0, -1, 30, 58, 89, 119, 150, 180, 211, 242, 272, 303, 333];
      double day = months[time.month] + time.day + ClockAngle.hour24.at(time);
      if (time.year % 4 == 0) { // leap year
        if (day > 59) day += 1;
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
