// lib/chord_generator.dart

class ChordGenerator {
  static Map<String, List<String>> majorScaleDegrees = {
    'C': ['Cmaj7', 'Dm7', 'Em7', 'Fmaj7', 'G7', 'Am7', 'Bø'],
    'F': ['Fmaj7', 'Gm7', 'Am7', 'Bbmaj7', 'C7', 'Dm7', 'Eø'],
    'G': ['Gmaj7', 'Am7', 'Bm7', 'Cmaj7', 'D7', 'Em7', 'F#ø'],
    // Add more keys as needed
  };

  static List<String> generateProgression(
      String progressionType, List<String> keys) {
    List<String> chords = [];

    for (String key in keys) {
      List<String>? scale = majorScaleDegrees[key];
      if (scale == null) continue; // Skip if key is not found

      if (progressionType == 'Major ii-V-I') {
        chords.addAll([
          scale[1], // ii
          scale[4], // V
          scale[0], // I
        ]);
        // Repeat to create a longer sequence if desired
        chords.addAll([
          scale[1],
          scale[4],
          scale[0],
        ]);
      }
      // Add more progression types as needed
    }

    return chords;
  }
}
