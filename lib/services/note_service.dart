import 'dart:convert';

import 'package:green_note/models/api_response.dart';
import 'package:green_note/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey' : '64fcf854-ee5c-4ef3-8bbf-088e66faa6fb',
  };

  Future<ApiResponse<List<Note>>> getNotes() {
    return http.get(API + '/notes', headers: headers)
        .then((data) {
          if(data.statusCode == 200) {
            final jsonData = json.decode(data.body);
            final notes = <Note>[];
            for(var item in jsonData) {
              final note = Note(
                id: item['noteID'],
                title: item['noteTitle'],
                createdAt: DateTime.parse(item['createDateTime']),
                editedAt: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null,
              );
              notes.add(note);
            }

            return ApiResponse<List<Note>>(
              data: notes
            );
          }
          return ApiResponse<List<Note>>(
              error: true,
              errorMessage: 'An error occured'
          );
    }).catchError((_) {
      return ApiResponse<List<Note>>(
          error: true,
          errorMessage: 'An error occured'
      );
    });
  }
}