// lib/chord_generator.dart

class ChordGenerator {
  static Map<String, List<String>> majorScaleDegrees = {
    'C': ['Cmaj7', 'Dm7', 'Em7', 'Fmaj7', 'G7', 'Am7', 'Bø'],
    'C#': ['C#maj7', 'D#m7', 'E#m7', 'F#maj7', 'G#7', 'A#m7', 'B#ø'],
    'D': ['Dmaj7', 'Em7', 'F#m7', 'Gmaj7', 'A7', 'Bm7', 'C#ø'],
    'Eb': ['Ebmaj7', 'Fm7', 'Gm7', 'Abmaj7', 'Bb7', 'Cm7', 'Dø'],
    'E': ['Emaj7', 'F#m7', 'G#m7', 'Amaj7', 'B7', 'C#m7', 'D#ø'],
    'F': ['Fmaj7', 'Gm7', 'Am7', 'Bbmaj7', 'C7', 'Dm7', 'Eø'],
    'F#': ['F#maj7', 'G#m7', 'A#m7', 'Bmaj7', 'C#7', 'D#m7', 'E#ø'],
    'G': ['Gmaj7', 'Am7', 'Bm7', 'Cmaj7', 'D7', 'Em7', 'F#ø'],
    'Ab': ['Abmaj7', 'Bbm7', 'Cm7', 'Dbmaj7', 'Eb7', 'Fm7', 'Gø'],
    'A': ['Amaj7', 'Bm7', 'C#m7', 'Dmaj7', 'E7', 'F#m7', 'G#ø'],
    'Bb': ['Bbmaj7', 'Cm7', 'Dm7', 'Ebmaj7', 'F7', 'Gm7', 'Aø'],
    'B': ['Bmaj7', 'C#m7', 'D#m7', 'Emaj7', 'F#7', 'G#m7', 'A#ø'],
  };

  static Map<String, List<String>> minorScaleDegrees = {
    'Am': ['Am7', 'Bm7b5', 'Cmaj7', 'Dm7', 'Em7', 'Fmaj7', 'G7'],
    'A#m': ['A#m7', 'B#m7b5', 'C#maj7', 'D#m7', 'E#m7', 'F#maj7', 'G#7'],
    'Bm': ['Bm7', 'C#m7b5', 'Dmaj7', 'Em7', 'F#m7', 'Gmaj7', 'A7'],
    'Cm': ['Cm7', 'Dm7b5', 'Ebmaj7', 'Fm7', 'Gm7', 'Abmaj7', 'Bb7'],
    'C#m': ['C#m7', 'D#m7b5', 'Emaj7', 'F#m7', 'G#m7', 'Amaj7', 'B7'],
    'Dm': ['Dm7', 'Em7b5', 'Fmaj7', 'Gm7', 'Am7', 'Bbmaj7', 'C7'],
    'D#m': ['D#m7', 'E#m7b5', 'F#maj7', 'G#m7', 'A#m7', 'Bmaj7', 'C#7'],
    'Em': ['Em7', 'F#m7b5', 'Gmaj7', 'Am7', 'Bm7', 'Cmaj7', 'D7'],
    'Fm': ['Fm7', 'Gm7b5', 'Abmaj7', 'Bbm7', 'Cm7', 'Dbmaj7', 'Eb7'],
    'F#m': ['F#m7', 'G#m7b5', 'Amaj7', 'Bm7', 'C#m7', 'Dmaj7', 'E7'],
    'Gm': ['Gm7', 'Am7b5', 'Bbmaj7', 'Cm7', 'Dm7', 'Ebmaj7', 'F7'],
    'G#m': ['G#m7', 'A#m7b5', 'Bmaj7', 'C#m7', 'D#m7', 'Emaj7', 'F#7'],
    'Bbm': ['Bbm7', 'Cm7b5', 'Dbmaj7', 'Ebm7', 'Fm7', 'Gbmaj7', 'Ab7'],
  };

  static List<String> generateProgression(
      String progressionType, List<String> keys) {
    List<String> chords = [];

    for (String key in keys) {
      List<String>? scale;
      if (progressionType == 'Major ii-V-I') {
        scale = majorScaleDegrees[key];
        if (scale == null) continue;
        chords.addAll([
          scale[1], // ii
          scale[4], // V
          scale[0], // I
        ]);
      } else if (progressionType == 'minor ii-V-i') {
        scale = minorScaleDegrees[key];
        if (scale == null) continue;
        chords.addAll([
          scale[1], // iiø
          scale[4], // V7
          scale[0], // i
        ]);
      } else if (progressionType == 'Single Chord') {
        chords.add(key);
      }
      chords.add('|'); // Sequence separator
    }

    if (chords.isNotEmpty && chords.last == '|') {
      chords.removeLast();
    }

    return chords;
  }
}
