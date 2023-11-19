import 'package:cloud_firestore/cloud_firestore.dart';

class RecieverInfoServices {
  final _db = FirebaseFirestore.instance;
  Future getName(String uid) async {
    final name = await _db.collection('users').doc(uid).get();
    return name.data()!['name'];
  }
}
