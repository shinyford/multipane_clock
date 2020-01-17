// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:multipane_clock/models/clock_angle.dart';

bool roughlyEqual(double a, double b) {
  if ((a - b).abs() < 0.000001) return true;
  print('Expected: $b, actual: $a');
  return false;
}

void main() {
  group('Clock Angle >', () {
    group('minute >', () {
      test('a minute is zero at the start', () {
        final DateTime dt = DateTime(2019, 1, 1);
        final double angle = ClockAngle.minute.at(dt);
        expect(angle, 0.0);
      });

      test('15 minutes is 0.25', () {
        final DateTime dt = DateTime(2019, 1, 1, 0, 15);
        final double angle = ClockAngle.minute.at(dt);
        expect(angle, 0.25);
      });

      test('40 minutes is 0.66', () {
        final DateTime dt = DateTime(2019, 1, 1, 0, 40);
        final double angle = ClockAngle.minute.at(dt);
        expect(roughlyEqual(angle, 2 / 3), true);
      });
    });

    group('hour >', () {
      test('an hour is zero at the start', () {
        final DateTime dt = DateTime(2019, 1, 1);
        final double angle = ClockAngle.hour.at(dt);
        expect(angle, 0.0);
      });

      test('3am is 0.25', () {
        final DateTime dt = DateTime(2019, 1, 1, 3);
        final double angle = ClockAngle.hour.at(dt);
        expect(angle, 0.25);
      });
    });

    group('hour24 >', () {
      test('an hour24 is zero at the start', () {
        final DateTime dt = DateTime(2019, 1, 1);
        final double angle = ClockAngle.hour24.at(dt);
        expect(angle, 0.0);
      });

      test('3am is 0.125', () {
        final DateTime dt = DateTime(2019, 1, 1, 3);
        final double angle = ClockAngle.hour24.at(dt);
        expect(angle, 0.125);
      });
    });

    group('day of year >', () {
      test('dayOfYear is zero on Jan 1', () {
        final DateTime dt = DateTime(2019, 1, 1);
        final double angle = ClockAngle.dayOfYear.at(dt);
        expect(angle, 0.0);
      });

      test('dayOfYear is 58 on Feb 28', () {
        final DateTime dt = DateTime(2019, 2, 28);
        final double angle = ClockAngle.dayOfYear.at(dt);
        expect(angle, 58 / 365);
      });

      test('dayOfYear is 59 on Mar 1', () {
        final DateTime dt = DateTime(2019, 3, 1);
        final double angle = ClockAngle.dayOfYear.at(dt);
        expect(angle, 59 / 365);
      });

      test('dayOfYear is 60 on Mar 1 in leap year', () {
        final DateTime dt = DateTime(2020, 3, 1);
        final double angle = ClockAngle.dayOfYear.at(dt);
        expect(angle, 60 / 366);
      });

      test('dayOfYear takes proportion of day into account', () {
        final DateTime dt = DateTime(2019, 3, 1, 6, 0, 0);
        final double angle = ClockAngle.dayOfYear.at(dt);
        expect(angle, 59.25 / 365);
      });

      test('dayOfYear is 365 on Dec 31 in leap year', () {
        final DateTime dt = DateTime(2020, 12, 31);
        final double angle = ClockAngle.dayOfYear.at(dt);
        expect(angle, 365 / 366);
      });
    });

    group('bouncy >', () {
      test('bouncyDay is zero at beginning', () {
        final DateTime dt = DateTime(2020, 1, 1);
        final double angle = ClockAngle.bouncyDay.at(dt);
        expect(angle, 0.0);
      });

      test('bouncyDay is zero at midday', () {
        final DateTime dt = DateTime(2020, 1, 1, 12);
        final double angle = ClockAngle.bouncyDay.at(dt);
        expect(angle, 0.0);
      });

      test('bouncyDay is zero at 23:58', () {
        final DateTime dt = DateTime(2020, 1, 1, 23, 58);
        final double angle = ClockAngle.bouncyDay.at(dt);
        expect(angle, 0.0);
      });

      test('bouncyDay is not zero at 23:59', () {
        final DateTime dt = DateTime(2020, 1, 1, 23, 59);
        final double angle = ClockAngle.bouncyDay.at(dt);
        expect(angle > 0.0, true);
      });
    });
  });
}
