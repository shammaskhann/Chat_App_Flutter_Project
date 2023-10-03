import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/SignupController/signup_controller.dart';
import 'package:flutter_firebase_project_app/view/Widgets/CustomWideButton.dart';
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
  bool isObsecure = true;
  File? _avatarImage;
  final AvatarController _controller = AvatarController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _pickImage(ImageSource source) async {
    final File? image = (source == ImageSource.gallery)
        ? await _controller.pickImageFromGallery()
        : await _controller.pickImageFromCamera();

    if (image != null) {
      setState(() {
        _avatarImage = image;
      });
    }
  }

  Future<void> _saveAvatar() async {
    final User? user = _auth.currentUser;
    print(_avatarImage);
    if (user != null && _avatarImage != null) {
      await _controller.uploadImageToFirebaseStorage(_avatarImage!, user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Create A ImagePicker Widget with Avatar
                  //Create A Text Widget with Text "Create Account"
                  //Create A Text Widget with Text "Please fill the input below here"
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
                          backgroundImage: (_avatarImage != null)
                              ? FileImage(_avatarImage!)
                              : null,
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              // signUpController.pickImage();
                              _pickImage(ImageSource.camera);
                              _saveAvatar();
                              // AvatarController().uploadImageToFirebaseStorage(
                              //     _avatarImage!, _auth.currentUser!.uid);
                              //_saveAvatar();
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.luminousGreen,
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
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
                            controller: signUpController.phoneNumberController,
                            focusNode: signUpController.phoneNumberFocusNode,
                            style: AppTextStyle.inputSignupTextFieldHint,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              signUpController.signUp(context);
                            },
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      title: "Sign Up",
                      loading: signUpController.loading,
                      onPressed: () {
                        signUpController.signUp(context);
                      })
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
