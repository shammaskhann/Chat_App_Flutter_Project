import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/routes.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/models/FirebaseAuth_services/Auth_services.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/utils.dart';

class SignUpController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  XFile? imgXFile;
  bool loading = false;

  void dispose() {
    Future.delayed(const Duration(milliseconds: 100), () {
      emailController.dispose();
      passwordController.dispose();
      phoneNumberController.dispose();
    });
  }

  Future signUp(BuildContext context, File avatarImage) async {
    final AuthServices authServices = AuthServices();
    loading = true;
    await authServices.authSignUp(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        phoneNumberController.text.trim(),
        avatarImage);
    Navigator.pushNamed(context, AppRoutes.loginScreen);
    loading = false;
  }
}
