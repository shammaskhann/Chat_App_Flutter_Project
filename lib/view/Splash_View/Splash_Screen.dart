import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';

import '../../resources/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image(
                image: AssetImage(AppImages.splashLogo),
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Chat App',
                style: TextStyle(
                  fontFamily: 'Aquire',
                  color: AppColors.luminousGreen,
                  fontSize: 50,
                ),
                textAlign: TextAlign.center,
              )
            ]),
          ),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
