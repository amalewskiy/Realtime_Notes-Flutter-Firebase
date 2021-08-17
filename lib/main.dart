import 'package:flutter/material.dart';
import 'list_all_notes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Realtime Notes',
        debugShowCheckedModeBanner: false,
        home: RealtimeNotes());
  }
}
