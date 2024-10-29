// lib/metronome.dart

export 'metronome_stub.dart' // Fallback implementation
    if (dart.library.io) 'metronome_mobile.dart'
    if (dart.library.html) 'metronome_web.dart';
