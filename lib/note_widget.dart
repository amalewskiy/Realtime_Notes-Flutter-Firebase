import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NoteWidget extends StatelessWidget {
  NoteWidget({Key? key, required this.id}) : super(key: key);
  String id;
  String _title = 'Новая заметка';
  String _description = '';
  String _date = '';

  String get title => _title;
  String get description => _description;
  String get date => _date;

  void setID(String id) {
    this.id = id;
  }

  void setTitle(String title) {
    _title = title;
  }

  void setDescription(String description) {
    _description = description;
  }

  void setDate(String date) {
    _date = date;
  }

  String _getCorrectTime() {
    var time = _date.split(' ');
    if (time[1] == DateFormat('dd.MM.yyyy').format(DateTime.now())) {
      return time[0];
    } else
      return time[1];
  }

  @override
  Widget build(BuildContext context) {
    String _formattedDate = _getCorrectTime();
    return Container(
      height: 120.0,
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Column(
        children: [
          Container(
              height: 25.0,
              width: double.infinity,
              alignment: Alignment.topLeft,
              child: Text(
                _title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              )),
          Container(
              height: 60.0,
              width: double.infinity,
              alignment: Alignment.topLeft,
              child: Text(
                _description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(fontSize: 14.0),
              )),
          Container(
              height: 15.0,
              width: double.infinity,
              alignment: Alignment.topRight,
              child: Text(
                _formattedDate,
                style: GoogleFonts.openSans(
                    fontSize: 12.0, fontStyle: FontStyle.italic),
              ))
        ],
      ),
    );
  }
}
