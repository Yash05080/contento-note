import 'package:flutter/foundation.dart';
import 'package:mario_frontend/database/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
//hive database
  final db = HiveDatabase();
//overall list of notes
  List<Note> allNotes = [];

  //initialize list
  void initializeNotes() {
    allNotes = db.loadNotes();
    print(db);
  }

// get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

//add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

//update a note
  void updateNote(Note note, String text) {
    //go thru list of allnotes
    for (int i = 0; i < allNotes.length; i++) {
      //find relevant note
      if (allNotes[i].id == note.id) {
        //replace text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }
//delete a note

  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
