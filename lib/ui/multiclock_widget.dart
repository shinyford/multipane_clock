import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multipane_clock/multipane_clock.dart';

class MulticlockWidget extends StatefulWidget {
  final List<ClockDefinition> clocks;
  final Duration showClockFor;

  MulticlockWidget({
    this.clocks,
    this.showClockFor = const Duration(seconds: 13),
    Key key
  }) : super(key: key);

  @override
  _MulticlockWidgetState createState() => _MulticlockWidgetState();
}

class _MulticlockWidgetState extends State<MulticlockWidget> with WidgetsBindingObserver {
  int _clockIndex = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.showClockFor, _updateClockIndex);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    _timer?.cancel();
    if (state == AppLifecycleState.resumed) {
      _timer = Timer.periodic(widget.showClockFor, _updateClockIndex);
    } else {
      _timer = null;
    }
  }

  void _updateClockIndex(_) {
    setState(() => _clockIndex = (_clockIndex + 1) ); //% widget.clocks.length);
  }

  @override
  Widget build(BuildContext context) {
    return MultipaneWidget(key: Key('Clock$_clockIndex'), clock: widget.clocks[_clockIndex % widget.clocks.length]);
  }
}
