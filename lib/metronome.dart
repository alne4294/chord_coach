// lib/metronome.dart

import 'package:flutter/scheduler.dart';

class Metronome {
  final Function onTick;
  final TickerProvider tickerProvider;
  Ticker? _ticker;
  late double _intervalInSeconds;
  double _accumulatedTime = 0.0;

  Metronome({required this.onTick, required this.tickerProvider});

  void start(int bpm) {
    _intervalInSeconds = 60.0 / bpm;
    _ticker = tickerProvider.createTicker(_tick)..start();
  }

  void _tick(Duration elapsed) {
    final double elapsedSeconds = elapsed.inMicroseconds / 1e6;
    final double deltaTime = elapsedSeconds - _accumulatedTime;

    if (deltaTime >= _intervalInSeconds) {
      onTick();
      _accumulatedTime = elapsedSeconds;
    }
  }

  void stop() {
    _ticker?.stop();
    _accumulatedTime = 0.0;
  }

  void dispose() {
    _ticker?.dispose();
  }
}
