// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'dart:math';
import 'package:test/test.dart';

import 'package:multipane_clock/models/angle_calculator.dart';

bool roughlyEqual(double a, double b) { // deal with fp rounding errors
  if ((a - b).abs() < 0.000001) return true;
  print('Expected: $b, actual: $a');
  return false;
}

void main() {
  group('Angle Calculator >', () {
    test('an arbitrary period returns the correct proportional values', () {
      final Random rand = Random();
      final int msecs = rand.nextInt(10000) + 10;
      final AngleCalculator calc = AngleCalculator(
        period: Duration(milliseconds: msecs),
      );
      final int time = rand.nextInt(4294967296);
      DateTime dt = DateTime.fromMillisecondsSinceEpoch(time);
      expect(roughlyEqual(calc.calculation(dt), 1.0 * (time % msecs) / msecs), true);
    });

    test('values returned can be shifted', () {
      final AngleCalculator calc = AngleCalculator(
        period: Duration(seconds: 16),
        adjustment: 0.25,
      );
      final DateTime dt = DateTime(2019, 1, 1, 0, 0, 0);
      expect(calc.calculation(dt), 0.25);
    });
  });
}
