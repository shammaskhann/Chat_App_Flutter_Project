import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';

import '../../resources/images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(AppImages.splashLogo),
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('CHAT APP',
                          style: TextStyle(
                              color: AppColors.luminousGreen,
                              fontSize: 36,
                              fontFamily: 'Aquire')),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontFamily: 'Mont',
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Sign in to continue!',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontFamily: 'Mont'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                          key: key,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                      fontFamily: 'Mont'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontFamily: 'Mont'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                      fontFamily: 'Mont'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontFamily: 'Mont'),
                              ),
                            ],
                          )),
                    ]),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
