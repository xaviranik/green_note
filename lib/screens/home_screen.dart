import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_note/models/note_model.dart';
import 'package:green_note/screens/note_modify_screen.dart';
import 'package:green_note/services/note_service.dart';
import 'package:green_note/widgets/note_delete_pop_up_widget.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NoteService get service => GetIt.I<NoteService>();
  List<Note> notes = [];

  String formattedDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    notes = service.getNoteList();
    super.initState();
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
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NoteModifyScreen(
                        id: notes[index].id,
                      ))),
              child: Dismissible(
                key: ValueKey(notes[index].id),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => NoteDeletePopup());
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: Align(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: Container(
                  width: double.infinity,
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
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
