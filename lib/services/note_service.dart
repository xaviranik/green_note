import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_note/models/api_response.dart';
import 'package:green_note/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey' : '64fcf854-ee5c-4ef3-8bbf-088e66faa6fb',
    'Content-Type' : 'application/json'
  };

  Future<ApiResponse<List<Note>>> getAllNotes() {
    return http.get(API + '/notes', headers: headers)
        .then((data) {
          if(data.statusCode == 200) {
            final jsonData = json.decode(data.body);
            final notes = <Note>[];
            for(var item in jsonData) {
              notes.add(Note.fromJson(item: item));
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

  Future<ApiResponse<Note>> getSingleNote({@required String id}) {
    return http.get(API + '/notes/' + id, headers: headers)
        .then((data) {
      if(data.statusCode == 200) {
        final Map jsonData = json.decode(data.body);
        final note = Note.fromJson(item: jsonData, flag: 'SINGLE');
        return ApiResponse<Note>(
            data: note
        );
      }
      return ApiResponse<Note>(
          error: true,
          errorMessage: 'An error occured'
      );
    }).catchError((_) {
      return ApiResponse<Note>(
          error: true,
          errorMessage: 'An error occured'
      );
    });
  }

  Future<ApiResponse<bool>> createNote(Note item) {
    return http.post(API + '/notes', headers: headers, body: json.encode(item.toMap()))
        .then((data) {
          print(data.body);
      if(data.statusCode == 201) {
        return ApiResponse<bool>(
            data: true
        );
      }
      return ApiResponse<bool>(
          error: true,
          errorMessage: 'An error occured'
      );
    }).catchError((_) {
      return ApiResponse<bool>(
          error: true,
          errorMessage: 'An error occured'
      );
    });
  }

  Future<ApiResponse<bool>> updateNote(Note item) {
    return http.put(API + '/notes/' + item.id, headers: headers, body: json.encode(item.toMap()))
        .then((data) {
      if(data.statusCode == 204) {
        return ApiResponse<bool>(
            data: true
        );
      }
      return ApiResponse<bool>(
          error: true,
          errorMessage: 'An error occured'
      );
    }).catchError((_) {
      return ApiResponse<bool>(
          error: true,
          errorMessage: 'An error occured'
      );
    });
  }

  Future<ApiResponse<bool>> deleteNote(Note item) {
    return http.delete(API + '/notes/' + item.id, headers: headers)
        .then((data) {
      if(data.statusCode == 204) {
        return ApiResponse<bool>(
            data: true
        );
      }
      return ApiResponse<bool>(
          error: true,
          errorMessage: 'An error occured'
      );
    }).catchError((_) {
      return ApiResponse<bool>(
          error: true,
          errorMessage: 'An error occured'
      );
    });
  }
}