import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudImageServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadImageToFirebaseStorage(File imageFile, String uid) async {
    final Reference storageRef =
        _storage.ref().child('avatars').child(uid).child('avatar.jpg');
    await storageRef.putFile(imageFile);
  }

  Future getImageFromFireBaseStorage(String uid) async {
    final Reference storageRef =
        _storage.ref().child('avatars').child(uid).child('avatar.jpg');
    return await storageRef.getDownloadURL();
  }
}
