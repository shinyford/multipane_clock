import 'package:flutter/animation.dart';

import 'package:multipane_clock/multipane_clock.dart';

// AngluarClockTime: a class that represents each time unit for a given datetime as a value x where 0 <= x < 1,
// being the fractional representation of integer unit value as a proportion of the next higher time unit.
// In other words answers the question: as a fraction of a circle, what angle should my hand point at for a given time?
// e.g. 32sec = 32/60 of the way round the circle; 576ms = 576/1000 of the way round; and so on
class AngularClockTime {
  final DateTime _time;

  AngularClockTime({DateTime time}) : _time = time ?? DateTime.now();

  static const _DerivedAngle siderialDayAngle = const _DerivedAngle(
    period:  ((((23 * 60) + 56) * 60) + 4) * 1000 + 100.0, // siderial day in ms: 23°56'04.1"
    adjustment:  0.07, // adjustment angle needed to push the siderial day to the right orientation
  );
  static const _DerivedAngle lunarDayAngle = const _DerivedAngle(
    period:  29.53 * 24 * 60 * 60 * 1000, // lunar day in ms: 29.53d
    adjustment:  0.39, // adjustment angle needed to push the lunar day to the right orientation
  );
  static const _DerivedAngle yearAngle = const _DerivedAngle(
    period:  365.25 * 24 * 60 * 60 * 1000, // a year in ms
    adjustment:  0.5, // adjustment angle needed to push the year dial to the right orientation
  );

  int get millisecondsSinceEpoch => _time.millisecondsSinceEpoch;

  double _millisecond;
  double _second;
  double _bouncySecond;
  double _minute;
  double _hour;
  double _hour24;
  double _meridien;
  double _bouncyMeridien;
  double _day;
  double _siderialDay;
  double _lunarDay;
  double _bouncyDay;
  double _dayOfYear;

  double get millisecond => _millisecond ??= _time.millisecond / 1000.0;
  double get second => _second ??= (_time.second + millisecond) / 60.0;
  double get minute => _minute ??= (_time.minute + second) / 60.0;
  double get hour => _hour ??= ((_time.hour % 12) + minute) / 12.0;
  double get hour24 => _hour24 ??= (_time.hour + minute) / 24.0;
  double get meridien => _meridien ??= ((_time.hour > 11 ? 1 : 0) + hour) / 2.0;
  double get day => _day ??= ((_time.day - 1) + meridien) / 31.0; // TODO fix visual weirdness when going from e.g. 28 Feb to 1 Mar
  double get siderialDay => _siderialDay ??= siderialDayAngle.at(_time);
  double get lunarDay => _lunarDay ??= lunarDayAngle.at(_time);
  double get year => _dayOfYear ??= yearAngle.at(_time);

  double get bouncySecond =>
      _bouncySecond ??= (_time.second + _dampedFinalRamp(millisecond, rampFrom: 0.25)) / 60.0; // dramp after initial quarter of each second
  double get bouncyMeridien =>
      _bouncyMeridien ??= ((_time.hour > 11 ? 1 : 0) + _finalRamp(hour, rampFrom: 715 / 720)) / 2.0; // ramp for the last five minutes of a meridien
  double get bouncyDay =>
      _bouncyDay ??= ((_time.day - 1) + _finalRamp(hour24, rampFrom: 1435 / 1440)) / 31.0; // ramp for the last five minutes of a day

  // angle as a fraction of a circle
  double angleFor(UnitOfTime unitOfTime) {
    switch (unitOfTime) {
      case UnitOfTime.dayOfYear: return year;
      case UnitOfTime.day: return day;
      case UnitOfTime.siderialDay: return siderialDay;
      case UnitOfTime.lunarDay: return lunarDay;
      case UnitOfTime.bouncyDay: return bouncyDay;
      case UnitOfTime.meridien: return meridien;
      case UnitOfTime.bouncyMeridien: return bouncyMeridien;
      case UnitOfTime.hour: return hour;
      case UnitOfTime.hour24: return hour24;
      case UnitOfTime.minute: return minute;
      case UnitOfTime.second: return second;
      case UnitOfTime.bouncySecond: return bouncySecond;
      case UnitOfTime.millisecond: return millisecond;
      default: return second;
    }
  }

  // keeps the value at zero until a sudden ramp up right at the end.
  double _finalRamp(double t, {double rampFrom}) {
    if (t < rampFrom) return 0;
    return (t - rampFrom) / (1 - rampFrom);
  }

  // as with `_finalRamp`, but with a damped effect on the ramp
  // to create a nice, clunky, mechanical bounce as of a second hand.
  double _dampedFinalRamp(double t, {double rampFrom}) =>
      Curves.bounceOut.transform(_finalRamp(t, rampFrom: rampFrom));
}

class _DerivedAngle {
  final double period;
  final double adjustment;

  const _DerivedAngle({this.period, this.adjustment});

  double at(DateTime time) {
    final double angle = (time.millisecondsSinceEpoch / period) + adjustment;
    return angle - angle.floor(); // we're only interested in the fractional component
  }
}
