import 'package:flutter/material.dart';

class Task{
  final int id;
  final String title;
  final String description;
  Task({this.id = 0,  this.title = '', this.description = '' });

  Map<String, dynamic> toMap() {
    return {
      'title' : title,
      'description' : description,
    };
  }
}