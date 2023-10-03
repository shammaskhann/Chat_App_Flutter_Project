import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/routes.dart';
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

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    imgXFile = await _picker.pickImage(source: ImageSource.gallery);
  }

  void dispose() {
    Future.delayed(const Duration(milliseconds: 100), () {
      emailController.dispose();
      passwordController.dispose();
      phoneNumberController.dispose();
      emailFocusNode.dispose();
      passwordFocusNode.dispose();
      phoneNumberFocusNode.dispose();
    });
  }

  Future signUp(BuildContext context) async {
    final AuthServices authServices = AuthServices();
    loading = true;
    await authServices.authSignUp(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        phoneNumberController.text.trim());
    dispose();
    Navigator.pushNamed(context, AppRoutes.loginScreen);
    loading = false;
  }
}
