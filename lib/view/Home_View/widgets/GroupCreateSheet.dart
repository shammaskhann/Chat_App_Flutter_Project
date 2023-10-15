import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/view/Widgets/CustomWideButton.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/utils.dart';
import '../../../constant/colors.dart';
import '../../../constant/textstyle.dart';
import '../../../controllers/AvatarControllor/avatar_controller.dart';

class GroupCreateSheet extends StatefulWidget {
  const GroupCreateSheet({super.key});

  @override
  State<GroupCreateSheet> createState() => _GroupCreateSheetState();
}

class _GroupCreateSheetState extends State<GroupCreateSheet> {
  final key = GlobalKey<FormState>();
  final _controller = AvatarController();
  File? groupAvatarImage;
  Future<void> _pickImage(ImageSource source) async {
    final File? image = (source == ImageSource.gallery)
        ? await _controller.pickImageFromGallery()
        : await _controller.pickImageFromCamera();

    if (image != null) {
      setState(() {
        groupAvatarImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Color(0xFF272A35),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 9,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      //Group Avatar
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.silverGray,
                              backgroundImage: (groupAvatarImage != null)
                                  ? FileImage(groupAvatarImage!)
                                  : null,
                              child: (groupAvatarImage == null)
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
                                  menuWidth:
                                      MediaQuery.of(context).size.width * 0.50,
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
                                  //   InkWell(
                                  //   onTap: () {

                                  //     // signUpController.pickImage();
                                  //     //_pickImage(ImageSource.camera);
                                  //     // AvatarController().uploadImageToFirebaseStorage(
                                  //     //     _avatarImage!, _auth.currentUser!.uid);
                                  //     //_saveAvatar();
                                  //   },
                                  //   child:
                                  // ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Group Name',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter group name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Group Description',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter group description';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Text(
                      //   'Add Users',
                      //   style: AppTextStyle.subtitle,
                      //   textAlign: TextAlign.start,
                      // ),
                      // Add Users to create group using search bar
                      // SearchBar(
                      //   backgroundColor: MaterialStateColor.resolveWith(
                      //       (states) => Colors.grey),
                      //   hintText: "Search..",
                      //   hintStyle: MaterialStateTextStyle.resolveWith(
                      //     (states) => const TextStyle(
                      //       fontFamily: 'Mont',
                      //       color: AppColors.white,
                      //     ),
                      //   ),
                      //   constraints: const BoxConstraints(
                      //     maxWidth: 300,
                      //     maxHeight: 50,
                      //   ),
                      //   onChanged: (value) {},
                      //   onTap: () {},
                      //   shadowColor: MaterialStateProperty.all(Colors.black),
                      //   shape: MaterialStateProperty.all(
                      //     RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   trailing: <Widget>[
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(
                      //         Icons.search,
                      //         color: AppColors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      CustomButton(
                          title: 'Create Group',
                          loading: false,
                          onPressed: () {
                            if (groupAvatarImage == null) {
                              Utils.toastMessage('Please select your avatar');
                              return;
                            }
                            if (key.currentState!.validate()) {
                              print('Group Created');
                            }
                          })
                    ],
                  ),
                ))
          ],
        ));
  }
}
