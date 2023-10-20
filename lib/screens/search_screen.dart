import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_samples/utils/database.dart';
import 'package:flutterfire_samples/widgets/item_list.dart';

class SearchNotes extends SearchDelegate<String> {
  static String? userUid;
  String? docId;
  // String title = '';
  // String description = '';

  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("notes");
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    Database.searchItem(query);
    return ItemList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search anything here"));
  }
}
