// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:multipane_clock/multipane_clock.dart';


void main() {
  final ClockAngle staticAngle = ClockAngle(function: (_) => 1);

  group('Vector >', () {
    test('a vector returns an angle according to its unitOfTime', () {
      final Vector vector = Vector(
        unitOfTime: staticAngle,
      );
      expect(vector.angleAt(null), 1);
    });

    test('a vector returns an angle scaled by its velocity', () {
      final Vector vector = Vector(
        unitOfTime: staticAngle,
        velocity: 3
      );
      expect(vector.angleAt(null), 3);
    });

    test('a vector returns an angle shifted by its angular offset', () {
      final Vector vector = Vector(
        unitOfTime: staticAngle,
        angularOffset: 3
      );
      expect(vector.angleAt(null), 4);
    });

    group('Pendulum >', () {
      test('a pendulum vector returns the start angle at the beginning', () {
        final Vector vector = Vector(
          unitOfTime: ClockAngle(function: (_) => 0),
          pendulumArc: 1
        );
        expect(vector.angleAt(null), 0.0);
      });

      test('a pendulum vector returns the full extent angle at its end', () {
        final Vector vector = Vector(
          unitOfTime: ClockAngle(function: (_) => 1),
          pendulumArc: 1
        );
        expect(vector.angleAt(null), 0.0);
      });

     test('a pendulum vector returns the maximum at its center', () {
        final Vector vector = Vector(
          unitOfTime: ClockAngle(function: (_) => 0.5),
          pendulumArc: 1
        );
        expect(vector.angleAt(null), 1.0);
      });

      group('with a start angle >', () {
        test('a pendulum vector returns the start angle at the beginning', () {
          final Vector vector = Vector(
            unitOfTime: ClockAngle(function: (_) => 0),
            pendulumArc: 0.5,
            pendulumOffset: -0.25
          );
          expect(vector.angleAt(null), -0.25);
        });

        test('a pendulum vector returns the full extent angle at its end', () {
          final Vector vector = Vector(
            unitOfTime: ClockAngle(function: (_) => 1),
            pendulumArc: 0.5,
            pendulumOffset: -0.25
          );
          expect(vector.angleAt(null), -0.25);
        });

      test('a pendulum vector returns the maximum at its center', () {
          final Vector vector = Vector(
            unitOfTime: ClockAngle(function: (_) => 0.5),
            pendulumArc: 0.5,
            pendulumOffset: -0.25
          );
          expect(vector.angleAt(null), 0.25);
        });
      });
    });
  });
}
