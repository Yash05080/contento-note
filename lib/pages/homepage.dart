import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario_frontend/models/note_data.dart';
import 'package:provider/provider.dart';

import 'Editing_Note_Page.dart';
import '../models/note.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //create a blank note
    Note newNote = Note(
      id: id,
      text: "",
    );

    //go to edit the note
    gotoNotePage(newNote, true);
  }

  //go to note editing page
  void gotoNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(
            note: note,
            isNewNote: isNewNote,
          ),
        ));
  }

  //delete the note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        /*appBar: AppBar(
        title:Text("TO DO",style: TextStyle(color: Colors.black),),

        backgroundColor: Colors.grey[50],
      ),*/
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 1,
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //heading
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 75),
                child: Text(
                  "Content Pages",
                  style: GoogleFonts.dmSerifText(fontSize: 48),
                ),
              ),
            ],
          ),
          value.getAllNotes().length == 0
              ? Container(
                  height: 300,
                  child: const Center(
                    child: Text(
                      "Let's start your journey",
                      style: TextStyle(fontSize: 30),
                    ),
                  ))
              : CupertinoListSection.insetGrouped(
                  children: List.generate(
                  value.getAllNotes().length,
                  (index) => CupertinoListTile(
                    title: Text(value.getAllNotes()[index].text),
                    onTap: () =>
                        gotoNotePage(value.getAllNotes()[index], false),
                    trailing: IconButton(
                        onPressed: () => deleteNote(value.getAllNotes()[index]),
                        icon: const Icon(Icons.delete)),
                  ),
                ))
        ]),
      ),
    );
  }
}
