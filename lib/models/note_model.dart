import 'package:flutter/material.dart';

class Note {
  String id;
  String title;
  DateTime createdAt;
  DateTime editedAt;

  Note({
    @required this.id,
    @required this.title,
    @required this.createdAt,
    @required this.editedAt
  });
}
