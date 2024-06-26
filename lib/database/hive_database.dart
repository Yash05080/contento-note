import 'package:hive_flutter/hive_flutter.dart';
import 'package:mario_frontend/models/note.dart';

class HiveDatabase {
  //refence our flutter box
  final _myBox = Hive.box('note_database');

  //load notes
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    //if there exist notes, return that, otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        //create individual note
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        //add to list
        savedNotesFormatted.add(individualNote);
      }
    } else {
      //default first note
      savedNotesFormatted.add(Note(id: 0, text: 'sample page'));
    }
    print(savedNotesFormatted);
    return savedNotesFormatted;
  }

  //save notes
  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    //each note has an id and text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }
    //then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
    print(_myBox);
    print(allNotesFormatted);
  }
}
