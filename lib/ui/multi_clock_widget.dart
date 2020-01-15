import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multipane_clock/multipane_clock.dart';

const int _CHANGE_CLOCK_MS = 20;

class MultiClockWidget extends StatefulWidget {
  final List<ClockDefinition> clocks;

  MultiClockWidget({this.clocks, Key key}) : super(key: key);

  @override
  _MultiClockWidgetState createState() => _MultiClockWidgetState();
}

class _MultiClockWidgetState extends State<MultiClockWidget> with WidgetsBindingObserver {
  int _clockIndex = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: _CHANGE_CLOCK_MS), _updateClockIndex);
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
      _timer = Timer.periodic(Duration(seconds: _CHANGE_CLOCK_MS), _updateClockIndex);
    } else {
      _timer = null;
    }
  }

  void _updateClockIndex(_) {
    setState(() => _clockIndex = (_clockIndex + 1) % widget.clocks.length);
  }

  @override
  Widget build(BuildContext context) {
    return MultiPaneWidget(key: Key('Clock$_clockIndex'), clock: widget.clocks[_clockIndex]);
  }
}
