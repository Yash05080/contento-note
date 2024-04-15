import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mario_frontend/note_data.dart';
import 'package:provider/provider.dart';

import 'Editing_Note_Page.dart';
import 'note.dart';

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
          backgroundColor: Colors.grey[300],
          elevation: 1,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //heading
          const Padding(
            padding: EdgeInsets.only(left: 25.0, top: 75),
            child: Text(
              "Notes",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
          ),
          value.getAllNotes().length == 0
              ? Container(
                  height: 300,
                  child: Center(
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
                                onPressed: () =>
                                    deleteNote(value.getAllNotes()[index]),
                                icon: Icon(Icons.delete)),
                          )))
        ]),
      ),
    );
  }
}
