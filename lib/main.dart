import 'package:flutter/material.dart';
import 'package:green_note/screens/home_screen.dart';
import 'package:green_note/screens/note_modify_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Nunito',
      ),
      home: HomeScreen(),
      routes: {
        '/note_modify' : (context) => NoteModifyScreen()
      },
    );
  }
}