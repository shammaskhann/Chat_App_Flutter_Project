import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/routes.dart';
import 'package:flutter_firebase_project_app/models/FirebaseAuth_services/Auth_services.dart';

import '../../Utils/utils.dart';

class AuthController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  bool loading = false;

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

  Future login(BuildContext context) async {
    bool isLogin;
    final AuthServices authServices = AuthServices();
    loading = true;
    isLogin = await authServices.authLogin(
        emailController.text.trim(), passwordController.text.trim());
    if (isLogin) {
      dispose();
      Navigator.pushNamed(context, AppRoutes.homeScreen);
      loading = false;
    } else {
      loading = false;
    }
  }

  Future signUp(BuildContext context) async {
    final AuthServices authServices = AuthServices();
    loading = true;
    authServices.authSignUp(emailController.text.trim(),
        passwordController.text.trim(), phoneNumberController.text.trim());
    dispose();
    Navigator.pushNamed(context, AppRoutes.loginScreen);
    loading = false;
  }
}
