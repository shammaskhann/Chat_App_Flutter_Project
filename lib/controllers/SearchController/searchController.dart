import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';

class Searchcontroller {
  final _db = FirebaseFirestore.instance;
  CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');
  Future<List> fetchUserList() async {
    final usersList = await _db.collection('users').get();
    return usersList.docs.toList();
  }

  List getUsersList() {
    List usersList = [];
    // _db.collection('users').get().then((value) {
    //   value.docs.forEach((element) {
    //     usersList.add(element.data());
    //   });
    // });
    //usersList = fetchUserList() as List;
    log(usersList.toString());
    return [
      {"name": "Rahul", "email": "email@test.pk"}
    ];
  }
}
