import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_note/screens/home_screen.dart';
import 'package:green_note/screens/note_modify_screen.dart';
import 'package:green_note/services/note_service.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => NoteService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

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