// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

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

class _MulticlockWidgetState extends State<MulticlockWidget> {
  InForegroundRepeater _repeater;
  int _faceIndex = 0;

  @override
  void initState() {
    super.initState();
    _repeater = InForegroundRepeater(period: widget.faceTime, onTick: _updateClockIndex);
  }

  @override
  void dispose() {
    _repeater?.cancel();
    super.dispose();
  }

  void _updateClockIndex(_) {
    setState(() => _faceIndex = (_faceIndex + 1) % widget.faces.length);
  }

  @override
  Widget build(BuildContext context) =>
      MultipaneWidget(key: Key('Clockface$_faceIndex'), face: widget.faces[_faceIndex]);
}
