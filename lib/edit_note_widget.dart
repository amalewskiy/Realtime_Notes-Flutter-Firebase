import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'note_widget.dart';

class EditNote extends StatelessWidget {
  const EditNote({Key? key, required this.noteWidget}) : super(key: key);
  final NoteWidget noteWidget;

  @override
  Widget build(BuildContext context) {
    String _titleWidget = noteWidget.title;
    String _descriptionWidget = noteWidget.description;
    TextEditingController _controllerTitle = TextEditingController();
    TextEditingController _controllerDescription = TextEditingController();
    _controllerTitle.text = _titleWidget;
    _controllerDescription.text = _descriptionWidget;
    List _getNoteData = [
      false,
      _controllerTitle.text,
      _controllerDescription.text
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (_titleWidget != _controllerTitle.text.trim() ||
                  _descriptionWidget != _controllerDescription.text.trim()) {
                _getNoteData[0] = true;
                _getNoteData[1] = _controllerTitle.text;
                _getNoteData[2] = _controllerDescription.text;
                _getNoteData.add(DateFormat('hh:mm').format(DateTime.now()));
              }
              Navigator.pop(context, _getNoteData);
            }),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.red,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 40.0,
                width: double.infinity,
                child: TextField(
                    controller: _controllerTitle,
                    style: GoogleFonts.openSans(
                        fontSize: 20.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Тема',
                      hintStyle: GoogleFonts.openSans(
                          fontSize: 20.0, color: Colors.black),
                    ))),
            Expanded(
              child: Container(
                child: TextField(
                    maxLines: 22,
                    controller: _controllerDescription,
                    style: GoogleFonts.openSans(
                        fontSize: 20.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Описание',
                      hintStyle: GoogleFonts.openSans(
                          fontSize: 20.0, color: Colors.grey),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
