import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  Future getAllUser() {
    return _db.collection('users').get();
  }
}
