// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

/*
 * `Pane`
 *
 * A container for an image which can be rotated and offset from its start position
 * when rendered.
 *
 * `Iterable<Vector> vectors`: one or more offsets from the start position, angled according to the time
 * `Rotation rotation`: the rotation of the image when finally rendered
 * `AssetImage image`: the image to render for the pane
 * `Size size`: the size of the image when rendered. Not necessarily the same as that of the image itself;
 * however, aspect ration should be kept the same
 * `Offset center`: the initial position of the center of the image, before vectors are applied
 */
class Pane {
  final Iterable<Vector> vectors;
  final Rotation rotation;
  final Offset position;
  final Image image;

  Pane({
    this.vectors,
    this.rotation,
    @required AssetImage image,
    @required Size size,
    @required Offset center,
  }) :
    this.image = Image(image: image, width: size.width, height: size.height),
    this.position = center - size.center(Offset.zero);

  bool get isRotating => rotation is Rotation;

  Offset positionAt(DateTime time) {
    Offset position = this.position;

    if (vectors is Iterable) {
      double cumulativeAngle = 0;

      for (Vector vector in vectors) {
        cumulativeAngle += vector.angleAt(time);
        position += vector.offsetFor(cumulativeAngle);
      }
    }

    return position;
  }

  double angleAt(DateTime time) =>
      rotation?.angleAt(time) ?? 0;
}
