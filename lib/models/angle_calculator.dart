import 'package:meta/meta.dart';

class AngleCalculator {
  final Duration period;
  final double adjustment;

  AngleCalculator({@required this.period, this.adjustment = 0});

  double calculation(DateTime time) {
    final double angle = (time.millisecondsSinceEpoch / period.inMilliseconds) + adjustment;
    return angle - angle.truncateToDouble(); // we're only interested in the fractional component
  }
}
