import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GroupController {
  final user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  final imgStore = FirebaseStorage.instance;
  createGroup(List selectedUsers, String groupName, String groupDescription,
      File groupImage) {
    if (groupImage != null) {
      imgStore
          .ref()
          .child('groupImages/${groupImage.path.split('/').last}')
          .putFile(groupImage)
          .then((value) => value.ref.getDownloadURL().then((value) {
                db
                    .collection('groups')
                    .doc(groupName)
                    .set({
                      'name': groupName,
                      'description': groupDescription,
                      'users': selectedUsers,
                      'createdBy': user!.uid,
                      'createdAt': DateTime.now(),
                      'groupImage': value,
                    })
                    .then((value) => print("Group Added"))
                    .catchError(
                        (error) => print("Failed to add group: $error"));
              }))
          .catchError((error) => print("Failed to add group: $error"));
    }
  }

  Future fetchGroups() {
    return db.collection('groups').get();
  }
}
