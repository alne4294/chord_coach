// lib/metronome_web.dart

import 'dart:html' as html;

class Metronome {
  final Function onTick;
  final int timeSignature;
  final int tempo;
  late html.AudioContext _audioContext;
  late double _intervalInSeconds;
  int beatCount = 0;
  late int _timerId;

  Metronome({
    required this.onTick,
    required this.timeSignature,
    required this.tempo,
  }) {
    _audioContext = html.AudioContext();
  }

  void start() {
    _intervalInSeconds = 60.0 / tempo;
    beatCount = 0;
    _scheduleTick();
  }

  void _scheduleTick() {
    _timerId = html.window.setTimeout(() {
      _playTickSound();
      onTick();
      beatCount = (beatCount + 1) % timeSignature;
      _scheduleTick();
    }, (_intervalInSeconds * 1000).toInt());
  }

  void _playTickSound() {
    final oscillator = _audioContext.createOscillator();
    final gainNode = _audioContext.createGain();

    oscillator.type = 'square';
    oscillator.frequency.setValueAtTime(
        (beatCount == 0) ? 1000 : 800, _audioContext.currentTime);

    gainNode.gain.setValueAtTime(1, _audioContext.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(
        0.001, _audioContext.currentTime + 0.2);

    oscillator.connectNode(gainNode);
    gainNode.connectNode(_audioContext.destination);

    oscillator.start2(0);
    oscillator.stop2(_audioContext.currentTime + 0.2);
  }

  void stop() {
    html.window.clearTimeout(_timerId);
    beatCount = 0;
  }

  void dispose() {
    _audioContext.close();
  }
}
