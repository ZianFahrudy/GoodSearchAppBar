import 'dart:async';

import 'package:flutter/foundation.dart';

/// Use debouncer to detect user not in typing
class Debouncer {
  Debouncer({this.duration});

  Duration? duration;
  VoidCallback? action;
  Timer? _timer;

  dynamic run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration ?? const Duration(milliseconds: 300), action);
  }
}
