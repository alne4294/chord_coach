// lib/metronome_mobile.dart

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_midi_pro/flutter_midi_pro.dart';
import 'package:flutter/scheduler.dart';

class Metronome {
  final Function onTick;
  final int timeSignature;
  final int tempo;
  late final Ticker _ticker;
  late double _intervalInSeconds;
  double _accumulatedTime = 0.0;
  int beatCount = 0;
  final FlutterMidiPro _flutterMidiPro = FlutterMidiPro();
  bool _isSoundFontLoaded = false;

  Metronome({
    required this.onTick,
    required this.timeSignature,
    required this.tempo,
  }) {
    _ticker = Ticker(_tick);
    _loadSoundFont();
  }

  void _loadSoundFont() async {
    ByteData sf2 = await rootBundle.load('assets/sf2/GeneralUser GS.sf2');
    await _flutterMidiPro.prepare(sf2: sf2);
    _isSoundFontLoaded = true;
  }

  void start() {
    if (!_isSoundFontLoaded) {
      // Wait until the SoundFont is loaded
      Timer(Duration(milliseconds: 500), () {
        _startTicker();
      });
    } else {
      _startTicker();
    }
  }

  void _startTicker() {
    _intervalInSeconds = 60.0 / tempo;
    _accumulatedTime = 0.0;
    beatCount = 0;
    _ticker.start();
  }

  void _tick(Duration elapsed) {
    final double elapsedSeconds = elapsed.inMicroseconds / 1e6;
    final double deltaTime = elapsedSeconds - _accumulatedTime;

    if (deltaTime >= _intervalInSeconds) {
      _playTickSound();
      onTick();
      _accumulatedTime += _intervalInSeconds;
      beatCount = (beatCount + 1) % timeSignature;
    }
  }

  void _playTickSound() {
    int midiNote = (beatCount == 0) ? 76 : 75; // E5 and D#5
    _flutterMidiPro.playNote(
      midi: midiNote,
      velocity: 127, // Max velocity for loudness
      durationMS: 100,
    );
  }

  void stop() {
    _ticker.stop();
    _accumulatedTime = 0.0;
    beatCount = 0;
  }

  void dispose() {
    _ticker.dispose();
    _flutterMidiPro.unmute();
    _flutterMidiPro.dispose();
  }
}
