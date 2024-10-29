// lib/widgets/chord_display.dart

import 'package:flutter/material.dart';

class ChordDisplay extends StatefulWidget {
  final List<String> chordSequence;
  final int currentChordIndex;

  ChordDisplay({required this.chordSequence, required this.currentChordIndex});

  @override
  _ChordDisplayState createState() => _ChordDisplayState();
}

class _ChordDisplayState extends State<ChordDisplay> {
  late ScrollController _scrollController;
  final double itemHeight = 60.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(ChordDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentChordIndex != oldWidget.currentChordIndex) {
      _scrollToCurrentChord();
    }
  }

  void _scrollToCurrentChord() {
    _scrollController.animateTo(
      (widget.currentChordIndex ~/ 6) * itemHeight,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chordSequence.isEmpty) {
      return Center(child: Text('No Chords to Display'));
    }

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: _buildGrid(),
      ),
    );
  }

  List<Widget> _buildGrid() {
    List<Widget> rows = [];
    List<Widget> currentRow = [];
    int count = 0;

    for (int i = 0; i < widget.chordSequence.length; i++) {
      String chord = widget.chordSequence[i];

      if (chord == '|') {
        // Add thick separator
        if (currentRow.isNotEmpty) {
          rows.add(Row(children: currentRow));
          currentRow = [];
        }
        rows.add(Divider(
          color: Colors.black,
          thickness: 2,
        ));
        count = 0;
        continue;
      }

      Widget chordWidget = Expanded(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: i == widget.currentChordIndex ? Colors.yellow : Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            chord,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

      currentRow.add(chordWidget);
      count++;

      if (count == 6) {
        rows.add(Row(children: currentRow));
        currentRow = [];
        count = 0;
      }
    }

    if (currentRow.isNotEmpty) {
      rows.add(Row(children: currentRow));
    }

    return rows;
  }
}
