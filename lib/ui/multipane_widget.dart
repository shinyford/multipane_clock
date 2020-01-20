// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'dart:math' as Math;

import 'package:flutter/material.dart';

import 'package:multipane_clock/multipane_clock.dart';


class MultipaneWidget extends StatefulWidget {
  final Clockface face;

  MultipaneWidget({this.face, Key key}) : super(key: key);

  @override
  _MultipaneWidgetState createState() => _MultipaneWidgetState();
}

class _MultipaneWidgetState extends State<MultipaneWidget> {
  static const Duration _UPDATE_PERIOD = const Duration(milliseconds: 30);

  Iterable<Pane> _panes;
  DateTime _time;
  InForegroundRepeater _repeater;
  Rect _screen;

  Clockface get face => widget.face;

  @override
  void initState() {
    super.initState();

    _time = face.time;
    _repeater = InForegroundRepeater(period: _UPDATE_PERIOD, onTick: _updateTime);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createPanes();
  }

  @override
  void dispose() {
    _repeater?.cancel();
    super.dispose();
  }

  void _createPanes() {
    final Size size = MediaQuery.of(context).size;
    _screen = _availableScreen(size);
    _panes = face.generate(_screen);
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

  void _updateTime(_) =>
      setState(() => _time = face.time);

  @override
  Widget build(BuildContext context) =>
      Stack(children: _panes.map(_pane).toList(growable: false));

  Widget _pane(Pane pane) =>
      PaneWidget(time: _time, pane: pane);
}
