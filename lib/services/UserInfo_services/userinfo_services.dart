import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';

class UserInfoServices {
  final user = FirebaseAuth.instance.currentUser;
  String get uid => user!.uid;
  String get email => user!.email!;
  Future getUserName() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc['name'];
  }

  Future getUserAvatar() {
    AvatarController avatarController = AvatarController();
    return avatarController.getAvatar(uid);
  }

  Future<String> getOtherUserName(String otherUid) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUid)
        .get();
    return doc['name'];
  }
}
