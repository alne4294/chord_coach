// lib/metronome_stub.dart

class Metronome {
  Metronome({
    required Function onTick,
    required int timeSignature,
    required int tempo,
  });

  void start() {
    throw UnsupportedError('Metronome is not supported on this platform.');
  }

  void stop() {}

  void dispose() {}
}
