import 'package:flutter/material.dart';
import 'package:sentiment_analysis/Textfield.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purple,
      title: const Text('CHECK THE SENTIMENT HERE!! YOU HUMAN'),
    ),
    body: const Textfield(),
  )));
}
