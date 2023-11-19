import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/controllers/SearchController/searchController.dart';
import 'package:flutter_firebase_project_app/view/GroupCreate_view/groupscreen_screen.dart';
import 'package:flutter_firebase_project_app/view/Widgets/CustomWideButton.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/utils.dart';

class GroupCreateModalSheet extends StatefulWidget {
  const GroupCreateModalSheet({super.key});

  @override
  State<GroupCreateModalSheet> createState() => _GroupCreateModalSheetState();
}

class _GroupCreateModalSheetState extends State<GroupCreateModalSheet> {
  final key = GlobalKey<FormState>();
  final _controller = AvatarController();
  final groupNameController = TextEditingController();
  final groupDescriptionComtroller = TextEditingController();
  File? groupAvatarImage;
  final _searchController = Searchcontroller();
  List<String> selectedUsers = [];
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
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          //Color(0xFF272A35),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: groupNameController,
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
                          controller: groupDescriptionComtroller,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, top: 10, bottom: 10),
                        child: CustomButton(
                            title: 'ADD MEMBERS',
                            loading: false,
                            onPressed: () {
                              if (groupAvatarImage == null) {
                                Utils.toastMessage('Please select your avatar');
                                return;
                              }
                              if (key.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupCreateScreen(
                                              groupAvatarImage:
                                                  groupAvatarImage!,
                                              groupName:
                                                  groupNameController.text,
                                              groupDescription:
                                                  groupDescriptionComtroller
                                                      .text,
                                            )));
                              }
                            }),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
