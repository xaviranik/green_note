import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_note/models/note_model.dart';

class HomeScreen extends StatelessWidget {
  final notes = [
    Note(
      id: '1',
      title: 'My awesome note 1',
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
    ),
    Note(
      id: '2',
      title: 'My awesome note 2',
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
    ),
    Note(
      id: '3',
      title: 'My awesome note 3',
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
    ),
    Note(
      id: '4',
      title: 'My awesome note 4',
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
    ),
  ];

  String formattedDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green Note'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/note_modify'),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    notes[index].title,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600]),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Last edited on: ${formattedDateTime(notes[index].editedAt)}',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
