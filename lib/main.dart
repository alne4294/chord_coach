// lib/main.dart

import 'package:flutter/material.dart';
import 'chord_generator.dart';
import 'metronome.dart';
import 'widgets/chord_display.dart';
import 'widgets/settings_form.dart';

void main() {
  runApp(JazzMetronomeApp());
}

class JazzMetronomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jazz Metronome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MetronomeHomePage(),
    );
  }
}

class MetronomeHomePage extends StatefulWidget {
  @override
  _MetronomeHomePageState createState() => _MetronomeHomePageState();
}

class _MetronomeHomePageState extends State<MetronomeHomePage>
    with SingleTickerProviderStateMixin {
  List<String> chordSequence = [];
  int tempo = 80;
  bool isPlaying = false;
  int currentChordIndex = 0;
  late Metronome metronome;

  @override
  void initState() {
    super.initState();
    metronome = Metronome(onTick: _onTick, tickerProvider: this);
  }

  void _onTick() {
    setState(() {
      currentChordIndex = (currentChordIndex + 1) % chordSequence.length;
    });
  }

  void _startMetronome() {
    if (chordSequence.isNotEmpty) {
      metronome.start(tempo);
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _stopMetronome() {
    metronome.stop();
    setState(() {
      isPlaying = false;
      currentChordIndex = 0;
    });
  }

  void _updateSettings(List<String> chords, int newTempo) {
    setState(() {
      chordSequence = chords;
      tempo = newTempo;
      currentChordIndex = 0;
    });
  }

  @override
  void dispose() {
    metronome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentChord =
        chordSequence.isNotEmpty ? chordSequence[currentChordIndex] : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Jazz Metronome'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChordDisplay(
              chordSequence: chordSequence,
              currentChordIndex: currentChordIndex,
            ),
          ),
          SettingsForm(
            onSettingsChanged: _updateSettings,
            isPlaying: isPlaying,
            tempo: tempo,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: isPlaying ? _stopMetronome : _startMetronome,
            child: Text(isPlaying ? 'Stop' : 'Start'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
