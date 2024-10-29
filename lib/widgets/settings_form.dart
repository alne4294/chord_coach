// lib/widgets/settings_form.dart

import 'package:flutter/material.dart';
import '../chord_generator.dart';

class SettingsForm extends StatefulWidget {
  final Function(List<String> chords, int tempo) onSettingsChanged;
  final bool isPlaying;
  final int tempo;

  SettingsForm({
    required this.onSettingsChanged,
    required this.isPlaying,
    required this.tempo,
  });

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  List<String> selectedKeys = ['C', 'F', 'G'];
  String selectedProgression = 'Major ii-V-I';
  late int tempo;

  @override
  void initState() {
    super.initState();
    tempo = widget.tempo;
  }

  void _generateChords() {
    List<String> chords = ChordGenerator.generateProgression(
        selectedProgression, selectedKeys);
    widget.onSettingsChanged(chords, tempo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TempoSlider(
          initialTempo: tempo,
          onTempoChanged: (value) {
            setState(() {
              tempo = value;
            });
          },
        ),
        SizedBox(height: 10),
        KeySelector(
          onKeysChanged: (keys) {
            selectedKeys = keys;
          },
          selectedKeys: selectedKeys,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: widget.isPlaying ? null : _generateChords,
          child: Text('Set Configuration'),
        ),
      ],
    );
  }
}

class TempoSlider extends StatelessWidget {
  final int initialTempo;
  final Function(int) onTempoChanged;

  TempoSlider({
    required this.initialTempo,
    required this.onTempoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tempo: $initialTempo BPM'),
        Slider(
          value: initialTempo.toDouble(),
          min: 40,
          max: 240,
          divisions: 200,
          label: '$initialTempo',
          onChanged: (value) {
            onTempoChanged(value.toInt());
          },
        ),
      ],
    );
  }
}

class KeySelector extends StatefulWidget {
  final Function(List<String>) onKeysChanged;
  final List<String> selectedKeys;

  KeySelector({
    required this.onKeysChanged,
    required this.selectedKeys,
  });

  @override
  _KeySelectorState createState() => _KeySelectorState();
}

class _KeySelectorState extends State<KeySelector> {
  final List<String> keys = [
    'C',
    'C#',
    'D',
    'Eb',
    'E',
    'F',
    'F#',
    'G',
    'Ab',
    'A',
    'Bb',
    'B'
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      children: keys.map((key) {
        return FilterChip(
          label: Text(key),
          selected: widget.selectedKeys.contains(key),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                widget.selectedKeys.add(key);
              } else {
                widget.selectedKeys.remove(key);
              }
              widget.onKeysChanged(widget.selectedKeys);
            });
          },
        );
      }).toList(),
    );
  }
}
