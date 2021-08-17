import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realtime_notes/firebase_functions.dart';
import 'edit_note_widget.dart';
import 'note_widget.dart';

class RealtimeNotes extends StatefulWidget {
  RealtimeNotes({Key? key}) : super(key: key);

  @override
  _RealtimeNotesState createState() => _RealtimeNotesState();
}

class _RealtimeNotesState extends State<RealtimeNotes> {
  List<NoteWidget> _allNotes = [];
  int _custId = 0;

  void _goToEditText(BuildContext context, int _custId, int index) async {
    final getData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditNote(noteWidget: _allNotes[index])));
    if (getData[0]) {
      setState(() {
        _allNotes[index].setTitle(getData[1]);
        _allNotes[index].setDescription(getData[2]);
        _allNotes[index].setDate(getData[3]);
        _allNotes.insert(0, _allNotes[index]);
        _allNotes.removeAt(index + 1);
      });
      updateFirebase(_allNotes);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List> _futureAllNotes = getListFromFirebase();
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime Notes'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: FutureBuilder<List>(
            future: _futureAllNotes,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No internet')));
                  return Center(child: Text('No internet connection :('));
                case ConnectionState.waiting:
                  return Center(child: const CircularProgressIndicator());
                default:
                  List lst1 = snapshot.data ?? [];
                  _allNotes.clear();
                  for (int i = 0; i < lst1.length; i++) {
                    _allNotes.add(NoteWidget(id: i.toString()));
                    var lst2 = lst1[i].values.toList();
                    _allNotes.last.setDate(lst2[0]);
                    _allNotes.last.setDescription(lst2[1]);
                    _allNotes.last.setTitle(lst2[2]);
                  }
                  _custId = _allNotes.length;
                  return _allNotes.isEmpty
                      ? Center(
                          child:
                              Text('No data', style: TextStyle(fontSize: 20)),
                        )
                      : ListView.builder(
                          itemCount: _allNotes.length,
                          padding: EdgeInsets.only(top: 5),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Dismissible(
                                key: Key(_allNotes[index].id),
                                onDismissed: (direction) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              '${_allNotes[index].title} dismissed')));
                                  setState(() {
                                    _allNotes.removeAt(index);
                                  });
                                  updateFirebase(_allNotes, remove: true);
                                  _custId = _allNotes.length;
                                },
                                background: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.delete),
                                      Icon(Icons.delete),
                                    ],
                                  ),
                                ),
                                child: ListTile(
                                    title: _allNotes[index],
                                    onTap: () {
                                      _goToEditText(context, _custId, index);
                                    }));
                          });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addToFirebase(_custId.toString(),
              time: DateFormat('hh:mm dd.MM.yyyy')
                  .format(DateTime.now())
                  .toString());
          setState(() {
            _allNotes.add(NoteWidget(id: _custId.toString()));
          });
          _custId++;
        },
        backgroundColor: Colors.amber,
      ),
    );
  }
}
