import 'dart:async';
import 'dart:math' as Math;

import 'package:flutter/material.dart';

import 'package:multipane_clock/multipane_clock.dart';

const int _CLOCK_CHANGE_PERIOD_MS = 10 * 1000;
const int _UPDATE_PERIOD_MS = 30;

class MultipaneWidget extends StatefulWidget {
  final List<ClockDefinition> clocks;

  MultipaneWidget({this.clocks, Key key}) : super(key: key);

  @override
  _MultipaneWidgetState createState() => _MultipaneWidgetState();
}

class _MultipaneWidgetState extends State<MultipaneWidget> with WidgetsBindingObserver {
  Iterable<Pane> _panes;
  AngularClockTime _time;
  Timer _updateTimer;
  int _clockIndex = 0;
  Rect _screen;

  ClockDefinition get clock =>
      widget.clocks[_clockIndex % widget.clocks.length];

  @override
  void initState() {
    super.initState();

    // deal with foregrounding/backgrounding via `didChangeAppLifecycleState` method
    WidgetsBinding.instance.addObserver(this);

    _time = AngularClockTime(time: clock.now);
    _updateTimer = _createUpdateTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createPanes();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _updateTimer?.cancel();
    if (state == AppLifecycleState.resumed) {
      _updateTimer = _createUpdateTimer();
    } else {
      _updateTimer = null;
    }
  }

  Timer _createUpdateTimer() =>
      Timer.periodic(Duration(milliseconds: _UPDATE_PERIOD_MS), _updateTime);

  void _createPanes() {
    final Size size = MediaQuery.of(context).size;
    _screen = _availableScreen(size);
    _panes = clock.generate(_screen);
  }

  Rect _availableScreen(Size size) {
    double width = size.width;
    double height = size.height;

    if (height > width) {
      height = 3 * width / 5;
    } else {
      height = Math.min(3 * width / 5, height);
      width = 5 * height / 3;
    }

    return Offset.zero & Size(width, height);
  }

  void _updateTime(_) {
    if (_time.millisecondsSinceEpoch % _CLOCK_CHANGE_PERIOD_MS < _UPDATE_PERIOD_MS) {
      _clockIndex += 1;
      _createPanes();
    }

    setState(() => _time = AngularClockTime(time: clock.now));
  }

  @override
  Widget build(BuildContext context) =>
      Stack(children: _panes.where(_shouldShow).map(_pane).toList(growable: false));

  bool _shouldShow(Pane pane) =>
      pane.shouldShowFor(_time);

  Widget _pane(Pane pane) =>
      PaneWidget(time: _time, pane: pane);
}
