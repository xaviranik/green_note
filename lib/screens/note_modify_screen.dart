import 'package:flutter/material.dart';

class NoteModifyScreen extends StatelessWidget {
  final String id;
  NoteModifyScreen({this.id});
  bool get isEditing => id != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Update Note' : 'Create Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Note title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Note content',
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Note',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
