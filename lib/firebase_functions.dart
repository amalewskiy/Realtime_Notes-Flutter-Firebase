import 'package:firebase_database/firebase_database.dart';

final databaseRef = FirebaseDatabase.instance.reference().child('Notes');

void addToFirebase(String id,
    {String title = 'Новая заметка',
    String description = '',
    String time = ''}) async {
  await databaseRef
      .child(id)
      .set({'title': title, 'description': description, 'date': time});
}

void removeFromFirebase(String id) async {
  await databaseRef.child(id).remove();
}

void updateFirebase(List list, {bool remove = false}) {
  if (remove) removeFromFirebase(list.isEmpty ? '0' : list.length.toString());
  for (int i = 0; i < list.length; i++) {
    list[i].setID(i.toString());
    addToFirebase(list[i].id,
        title: list[i].title,
        description: list[i].description,
        time: list[i].date);
  }
}

Future<List> getListFromFirebase() async {
  var listData = await databaseRef
      .once()
      .then((DataSnapshot snapshot) => snapshot.value ?? []);
  return listData;
}
