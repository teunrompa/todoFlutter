import 'package:flutter/material.dart';

class Task{
  final int id;
  final String title;
  final String description;
  Task({this.id = 0,  this.title = '(No title given)', this.description = '(no description given)' });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title' : title,
      'description' : description,
    };
  }
}

