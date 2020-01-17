import 'package:test/test.dart';

import 'package:multipane_clock/models/angle_calculator.dart';

bool roughlyEqual(double a, double b) {
  if ((a - b).abs() < 0.000001) return true;
  print('Expected: $b, actual: $a');
  return false;
}

void main() {
  group('Angle Calculator >', () {
    test('an arbitrary period returns proprotional values', () {
      final int secs = 16;
      final AngleCalculator calc = AngleCalculator(
        period: Duration(seconds: secs),
      );
      for (int i = 0; i < secs; ++i) {
        final DateTime dt = DateTime(2019, 1, 1, 0, 0, i);
        expect(calc.calculation(dt), i / secs);
      }
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
