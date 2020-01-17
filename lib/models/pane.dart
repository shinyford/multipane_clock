import 'package:flutter/widgets.dart';

import 'package:multipane_clock/multipane_clock.dart';

class Pane {
  final Iterable<Vector> vectors;
  final Offset position;
  final Image image;
  final Rotation rotation;

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
        cumulativeAngle += vector.angleFor(time);
        position += vector.offsetFor(cumulativeAngle);
      }
    }

    return position;
  }

  double angleFor(DateTime time) =>
      rotation?.angleFor(time) ?? 0;
}
