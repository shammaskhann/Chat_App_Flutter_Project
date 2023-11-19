import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/services/SplashScreen_services/splash_controller.dart';

import '../../constant/routes.dart';

class SplashController {
  void initSplash(BuildContext context) async {
    bool isUser;
    SplashServices splashServices = SplashServices();
    await Future.delayed(const Duration(seconds: 3));
    isUser = await splashServices.checkUser();
    if (isUser) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
  }
}
