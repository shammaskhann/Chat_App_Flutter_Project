import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';

import '../../Utils/utils.dart';
import '../../constant/routes.dart';
import '../../controllers/LoginController/login_controller.dart';
import '../../resources/images.dart';
import '../Widgets/CustomWideButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  LoginController loginController = LoginController();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              // height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.greyBackGround,
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
                      const SizedBox(
                        height: 20,
                      ),
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
                              //email address
                              TextFormField(
                                controller: loginController.emailController,
                                focusNode: loginController.emailFocusNode,
                                style: AppTextStyle.textFieldText,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: AppColors.luminousGreen,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email Address';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  Utils.fieldFocusChange(
                                      context,
                                      loginController.emailFocusNode,
                                      loginController.passwordFocusNode);
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                      left: 25,
                                      top: 25,
                                      bottom: 25,
                                    ),
                                    fillColor: AppColors.white,
                                    hintText: 'Enter Email',
                                    hintStyle: AppTextStyle.inputTextFieldHint,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: AppColors.silverGray,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //PassWord
                              TextFormField(
                                controller: loginController.passwordController,
                                focusNode: loginController.passwordFocusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  loginController.passwordFocusNode.unfocus();
                                },
                                style: AppTextStyle.textFieldText,
                                obscureText: isObsecure,
                                obscuringCharacter: '•',
                                cursorColor: AppColors.primaryColor,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                      left: 25,
                                      top: 25,
                                      bottom: 25,
                                    ),
                                    fillColor: AppColors.white,
                                    hintText: 'Enter Password',
                                    hintStyle: AppTextStyle.inputTextFieldHint,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: AppColors.silverGray,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isObsecure = !isObsecure;
                                          setState(() {});
                                        });
                                      },
                                      child: Icon(
                                        isObsecure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColors.silverGray,
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Switch(
                                        inactiveTrackColor:
                                            AppColors.silverGray,
                                        activeColor: AppColors.luminousGreen,
                                        value: loginController.isRememberMe,
                                        onChanged: (value) {
                                          loginController.isRememberMe = value;
                                          setState(() {});
                                        }),
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: AppTextStyle.subtitle,
                                  ),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Forgot Password',
                                        style: AppTextStyle.subtitle,
                                      )),
                                ],
                              ),
                              //Login Button
                              CustomButton(
                                title: 'Login',
                                loading: loginController.loading,
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    loginController.login(context);
                                  }
                                },
                              ),
                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.signupScreen);
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                          text: 'Don\'t have an account? ',
                                          style: AppTextStyle.subtitle,
                                          children: [
                                            TextSpan(
                                              text: 'Sign Up',
                                              style: TextStyle(
                                                color: AppColors.luminousGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ]),
                                    )),
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
