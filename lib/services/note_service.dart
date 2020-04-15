import 'package:green_note/models/note_model.dart';

class NoteService {
  List<Note> getNoteList() {
    return [
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
  }
}