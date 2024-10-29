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
      widget.currentChordIndex * itemHeight,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chordSequence.isEmpty) {
      return Center(child: Text('No Chords to Display'));
    }

    return ListView.builder(
      controller: _scrollController,
      itemExtent: itemHeight,
      itemCount: widget.chordSequence.length,
      itemBuilder: (context, index) {
        return Container(
          color:
              index == widget.currentChordIndex ? Colors.yellow : Colors.white,
          child: ListTile(
            title: Center(
              child: Text(
                widget.chordSequence[index],
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}
