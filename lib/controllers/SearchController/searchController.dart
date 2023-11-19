import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_project_app/services/Chat_services/chat_services.dart';

class Searchcontroller {
  final _db = FirebaseFirestore.instance;
  CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');
  Future fetchUserList() async {
    final usersList = await _db.collection('users').get();
    return usersList ;
  }
  searchUser(String query){
    return _db.collection('users').where('name',isGreaterThanOrEqualTo: query).get();
  }

}
