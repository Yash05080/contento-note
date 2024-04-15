import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:mario_frontend/ai/consts.dart';
import 'package:mario_frontend/models/note_data.dart';

import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import 'models/note.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  await Hive.initFlutter();
  Hive.registerAdapter(
      NoteAdapter()); // Register adapter to use it in your file...it is necessary for saving
  await Hive.openBox('note_database');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
