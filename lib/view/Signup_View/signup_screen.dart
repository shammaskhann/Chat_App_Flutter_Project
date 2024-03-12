import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/SignupController/signup_controller.dart';
import 'package:flutter_firebase_project_app/view/Widgets/CustomWideButton.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/utils.dart';
import '../../controllers/AvatarControllor/avatar_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignUpController signUpController = SignUpController();
  final key = GlobalKey<FormState>();
  final AvatarController _controller = AvatarController();
  static File? avatarImage;
  bool isObsecure = true;
  Future<void> _pickImage(ImageSource source) async {
    final File? image = (source == ImageSource.gallery)
        ? await _controller.pickImageFromGallery()
        : await _controller.pickImageFromCamera();

    if (image != null) {
      setState(() {
        avatarImage = image;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    avatarImage = null;
    signUpController.nameController.dispose();
    signUpController.emailController.dispose();
    signUpController.passwordController.dispose();
    signUpController.phoneNumberController.dispose();
    signUpController.nameFocusNode.dispose();
    signUpController.emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Create Account',
                  style: AppTextStyle.heading,
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.silverGray,
                        backgroundImage: (avatarImage != null)
                            ? FileImage(avatarImage!)
                            : null,
                        child: (avatarImage == null)
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primaryColor,
                              )
                            : null,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: FocusedMenuHolder(
                            menuWidth: MediaQuery.of(context).size.width * 0.50,
                            blurSize: 2.0,
                            menuOffset: 10.0,
                            animateMenuItems: true,
                            openWithTap: true,
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.luminousGreen,
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            onPressed: () {},
                            menuItems: [
                              FocusedMenuItem(
                                title: const Text("Camera"),
                                trailingIcon: const Icon(Icons.camera),
                                onPressed: () {
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                              FocusedMenuItem(
                                title: const Text("Gallery"),
                                trailingIcon: const Icon(Icons.image),
                                onPressed: () {
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: signUpController.nameController,
                          focusNode: signUpController.nameFocusNode,
                          style: AppTextStyle.inputSignupTextFieldHint,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context,
                                signUpController.nameFocusNode,
                                signUpController.emailFocusNode);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: AppColors.silverGray,
                            ),
                            hintText: 'Enter Full Name',
                            hintStyle: AppTextStyle.inputTextFieldHint,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.silverGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.errorRed,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          controller: signUpController.emailController,
                          focusNode: signUpController.emailFocusNode,
                          style: AppTextStyle.inputSignupTextFieldHint,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context,
                                signUpController.emailFocusNode,
                                signUpController.passwordFocusNode);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: AppColors.silverGray,
                            ),
                            hintText: 'Enter Email',
                            hintStyle: AppTextStyle.inputTextFieldHint,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.silverGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.errorRed,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: signUpController.passwordController,
                          focusNode: signUpController.passwordFocusNode,
                          style: AppTextStyle.inputSignupTextFieldHint,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context,
                                signUpController.passwordFocusNode,
                                signUpController.phoneNumberFocusNode);
                          },
                          obscureText: isObsecure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: AppColors.silverGray,
                            ),
                            hintText: 'Enter Password',
                            hintStyle: AppTextStyle.inputTextFieldHint,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.silverGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.errorRed,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObsecure = !isObsecure;
                                });
                              },
                              icon: Icon(
                                isObsecure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.silverGray,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          controller: signUpController.phoneNumberController,
                          focusNode: signUpController.phoneNumberFocusNode,
                          style: AppTextStyle.inputSignupTextFieldHint,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: AppColors.silverGray,
                            ),
                            hintText: 'Enter Phone Number',
                            hintStyle: AppTextStyle.inputTextFieldHint,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.silverGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.errorRed,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.luminousGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(
                    title: "Sign Up",
                    loading: signUpController.loading,
                    onPressed: () {
                      if (avatarImage == null) {
                        Utils.toastMessage('Please select your avatar');
                        return;
                      }
                      if (key.currentState!.validate()) {
                        setState(() {
                          signUpController.loading = true;
                        });
                        signUpController.signUp(context, avatarImage!);
                      }
                    }),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
