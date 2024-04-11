import 'package:flutter/material.dart';

class MyNotesApp extends StatefulWidget {
  @override
  _MyNotesAppState createState() => _MyNotesAppState();
}

class _MyNotesAppState extends State<MyNotesApp> {
  List<String> _noteHistory = ['']; // History of note content
  int _currentNoteIndex = 0; // Index of the current note content

  void _updateNoteContent(String newContent) {
    setState(() {
      _noteHistory.add(newContent);
      _currentNoteIndex = _noteHistory.length - 1;
    });
  }

  void _undo() {
    if (_currentNoteIndex > 0) {
      setState(() {
        _currentNoteIndex--;
      });
    }
  }

  void _redo() {
    if (_currentNoteIndex < _noteHistory.length - 1) {
      setState(() {
        _currentNoteIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentNoteContent = _noteHistory[_currentNoteIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                onChanged: _updateNoteContent,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter your note...',
                ),
                controller: TextEditingController(text: currentNoteContent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _undo,
                  child: Text('Undo'),
                ),
                ElevatedButton(
                  onPressed: _redo,
                  child: Text('Redo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
