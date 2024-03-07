import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/controllers/Splash_Controller/splash_controller.dart';

import '../../resources/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = SplashController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashController.initSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image(
            image: AssetImage(AppImages.splashLogo),
            height: 50,
            width: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Convo\nConnect',
            style: TextStyle(
              fontFamily: 'Aquire',
              fontWeight: FontWeight.w600,
              color: AppColors.luminousGreen,
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
          )
        ]),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
