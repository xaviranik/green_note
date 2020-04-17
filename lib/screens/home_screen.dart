import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_note/models/api_response.dart';
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
  ApiResponse<List<Note>> _apiResponse;
  bool _isLoading = false;

  String formattedDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  void _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getAllNotes();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchNotes();
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
        onPressed: () => Navigator.pushNamed(context, '/note_modify').then((_) {
          _fetchNotes();
        }),
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse == null) {
            return Center(child: Text("Something went wrong..."));
          }

          return ListView.builder(
              itemCount: _apiResponse.data.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (_) => NoteModifyScreen(
                                id: _apiResponse.data[index].id,
                              )))
                      .then((_) {
                    _fetchNotes();
                  }),
                  child: Dismissible(
                    key: ValueKey(_apiResponse.data[index].id),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _apiResponse.data[index].title,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600]),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Last edited on: ${formattedDateTime(_apiResponse.data[index].editedAt ?? _apiResponse.data[index].createdAt)}',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
