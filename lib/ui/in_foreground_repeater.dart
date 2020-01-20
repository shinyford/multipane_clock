// Copyright (c) 2020, Nic Ford.  All rights reserved. Use of this source code is
// governed by an Apache-2.0 license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';

typedef _TimerCallback = void Function(Timer);

class InForegroundRepeater extends WidgetsBindingObserver {
  final _TimerCallback onTick;
  final Duration period;

  Timer _timer;

  InForegroundRepeater({this.period, this.onTick}) {
    _timer = _createTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  void cancel() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
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

  Timer _createTimer() => Timer.periodic(period, onTick);
}
