import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class Database {
  static String? userUid;
  static Stream<QuerySnapshot>? itemsList;
  static bool sortType = true;

  static Future<void> addItem({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "createdOn": DateTime.now(),
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "createdOn": DateTime.now(),
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static void readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('items');
    itemsList = notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  static void sortItems() {
    Query<Map<String, dynamic>>? notesItemCollection;
    if (sortType) {
      notesItemCollection = _mainCollection
          .doc(userUid)
          .collection('items')
          .orderBy('title', descending: false);
      sortType = false;
    } else {
      notesItemCollection = _mainCollection
          .doc(userUid)
          .collection('items')
          .orderBy('title', descending: true);
      sortType = true;
    }

    itemsList = notesItemCollection.snapshots();
  }

  static void searchItem(final String title) {
    Query<Map<String, dynamic>> notesItemCollection = _mainCollection
        .doc(userUid)
        .collection('items')
        .where("title", isEqualTo: title);
    itemsList = notesItemCollection.snapshots();
  }
}
