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
  bool get isEditing => widget.id != null;
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

  @override
  void initState() {
    _fetchNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Update Note' : 'Create Note'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse == null) {
            return Center(child: Text("Something went wrong..."));
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
          );
        },
      ),
    );
  }
}
