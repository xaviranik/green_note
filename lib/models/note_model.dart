import 'package:flutter/material.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime editedAt;

  factory Note.fromJson({Map<String, dynamic> item, int flag}) {
    if(flag == 1) {
      return Note.single(
        id: item['noteID'],
        content: item['noteContent'],
        title: item['noteTitle'],
        createdAt: DateTime.parse(item['createDateTime']),
        editedAt: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null,
      );
    }
    return Note.all(
      id: item['noteID'],
      title: item['noteTitle'],
      createdAt: DateTime.parse(item['createDateTime']),
      editedAt: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null,
    );
  }

  Note.all({
    @required this.id,
    @required this.title,
    @required this.createdAt,
    @required this.editedAt
  });

  Note.single({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.createdAt,
    @required this.editedAt
  });
}
