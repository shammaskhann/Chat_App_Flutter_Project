import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/controllers/SignupController/auth_Exception.dart';

import '../../Utils/utils.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future authSignUp(String name, String email, String password, String phone,
      File avatarImage) async {
    AvatarController _avatarController = AvatarController();
    await auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      await _avatarController.saveAvatar(avatarImage, value.user!.uid);
      Utils.toastMessage('Account Created Successfully');
      await _db.collection('users').doc(value.user!.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phone,
        'uid': value.user!.uid,
      });
    }).catchError((error) {
      AuthException.authExceptionToast(error.code);
    });
  }

  Future<bool> authLogin(String email, String password) async {
    return await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Utils.toastMessage('Login Successfully');
      return true;
    }).catchError((error) {
      AuthException.authExceptionToast(error.code);
      return false;
    });
  }
}
