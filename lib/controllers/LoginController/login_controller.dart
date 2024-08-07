import 'package:flutter/material.dart';

import '../../constant/routes.dart';
import '../../services/FirebaseAuth_services/Auth_services.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool loading = false;
  bool isRememberMe = true;

  void dispose() {
    Future.delayed(const Duration(milliseconds: 100), () {
      emailController.clear();
      passwordController.clear();
      emailFocusNode.dispose();
      passwordFocusNode.dispose();
    });
  }

  Future login(BuildContext context) async {
    bool isLogin;
    final AuthServices authServices = AuthServices();
    loading = true;
    isLogin = await authServices.authLogin(
        emailController.text.trim(), passwordController.text.trim());
    if (isLogin) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      loading = false;
    } else {
      loading = false;
    }
  }
}
