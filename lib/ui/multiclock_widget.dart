// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:multipane_clock/multipane_clock.dart';

class MulticlockWidget extends StatefulWidget {
  final List<Clockface> faces;
  final Duration faceTime;

  MulticlockWidget({
    this.faces,
    this.faceTime = const Duration(seconds: 13),
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
    _timer = _createTimer();
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
      _timer = _createTimer();
    } else {
      _timer = null;
    }
  }

  Timer _createTimer() =>
      Timer.periodic(widget.faceTime, _updateClockIndex);

  void _updateClockIndex(_) {
    setState(() => _clockIndex = (_clockIndex + 1) ); //% widget.clocks.length);
  }

  @override
  Widget build(BuildContext context) {
    return MultipaneWidget(key: Key('Clock$_clockIndex'), face: widget.faces[_clockIndex % widget.faces.length]);
  }
}
