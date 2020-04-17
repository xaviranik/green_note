import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_note/models/api_response.dart';
import 'package:green_note/models/note_model.dart';
import 'package:green_note/services/note_service.dart';

class NoteModifyScreen extends StatefulWidget {
  final String id;

  NoteModifyScreen({this.id});

  @override
  _NoteModifyScreenState createState() => _NoteModifyScreenState();
}

class _NoteModifyScreenState extends State<NoteModifyScreen> {
  bool get _isEditing => widget.id != null;

  NoteService get service => GetIt.I<NoteService>();

  ApiResponse<Note> _apiResponse;
  bool _isLoading = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  void _fetchNote() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getSingleNote(id: widget.id);
    _titleController.text = _apiResponse.data.title;
    _contentController.text = _apiResponse.data.content;

    setState(() {
      _isLoading = false;
    });
  }

  void _createNote() async {
    setState(() {
      _isLoading = true;
    });

    final note = Note.create(
        title: _titleController.text,
        content: _contentController.text
    );
    final response = await service.createNote(note);

    setState(() {
      _isLoading = false;
    });

    if(!response.error) {
      _showAlert(title: 'Note Added', content: 'Your note has been added successfully!');
    }
  }

  void _updateNote() async {
    setState(() {
      _isLoading = true;
    });

    final note = Note.update(
        id: widget.id,
        title: _titleController.text,
        content: _contentController.text
    );
    final response = await service.updateNote(note);

    setState(() {
      _isLoading = false;
    });
    if(!response.error) {
      _showAlert(title: 'Note Updated', content: 'Your note has been updated successfully!');
    }
  }

  void _showAlert({String title, String content}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    ).then((data) {
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    if (_isEditing) {
      _fetchNote();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Update Note' : 'Create Note'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Note title',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: 'Note content',
                  ),
                ),
                SizedBox(height: 32.0),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (_isEditing) {
                        _updateNote();
                      } else {
                        _createNote();
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      _isEditing ? 'Update Note' : 'Add Note',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
