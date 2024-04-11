// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mario_frontend/note_data.dart';
import 'package:provider/provider.dart';
import 'note.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;

  EditingNotePage({
    Key? key, // Fix the key parameter here
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }
  //load existing note

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  //add a new note
  void addNewNote() {
    //get new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //get text from editor
    String text = _controller.document.toPlainText();
    //add a new note
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

// updating a existing note
  void updateNote() {
    //get text from editor
    String text = _controller.document.toPlainText();
    //update data
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //if new note
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            }

            //if existing note
            else {
              updateNote();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          //toolbar
          Center(
            child: QuillSimpleToolbar(
              configurations: QuillSimpleToolbarConfigurations(
                controller: _controller,
                showAlignmentButtons: false,
                showBoldButton: false,
                showBackgroundColorButton: false,
                showCenterAlignment: false,
                showClearFormat: false,
                showCodeBlock: false,
                showColorButton: false,
                showDirection: false,
                showIndent: false,
                showInlineCode: false,
                showDividers: false,
                showFontFamily: false,
                showFontSize: false,
                showHeaderStyle: false,
                showItalicButton: false,
                showJustifyAlignment: false,
                showLeftAlignment: false,
                showLink: false,
                showListBullets: false,
                showListCheck: false,
                showListNumbers: false,
                showQuote: false,
                showRightAlignment: false,
                showSearchButton: false,
                showSmallButton: false,
                showStrikeThrough: false,
                showSubscript: false,
                showSuperscript: false,
                showUnderLineButton: false,
              ),
            ),
          ),

          //editor
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
              controller: _controller,
              readOnly: false,
            )),
          )
        ],
      ),
    );
  }
}
