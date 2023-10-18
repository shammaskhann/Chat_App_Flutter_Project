import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/view/Widgets/CustomWideButton.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import '../../../Utils/utils.dart';
import '../../../constant/colors.dart';
import '../../../constant/textstyle.dart';
import '../../../controllers/AvatarControllor/avatar_controller.dart';
import '../../../controllers/SearchController/searchController.dart';

class GroupCreateSheet extends StatefulWidget {
  const GroupCreateSheet({super.key});

  @override
  State<GroupCreateSheet> createState() => _GroupCreateSheetState();
}

class _GroupCreateSheetState extends State<GroupCreateSheet> {
  final key = GlobalKey<FormState>();
  final _controller = AvatarController();
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
        height: MediaQuery.of(context).size.height * 0.85,
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
                      const SizedBox(
                        height: 10,
                      ),
                      //A Field for selecting users for group chat like a search which give user tile with a add button at suffix and a list of selected users
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MultiSelect(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            titleText: 'Select Users',
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one or more option(s)';
                              }
                              return null;
                            },
                            errorText: 'Please select one or more option(s)',
                            dataSource: _searchController.getUsersList(),
                            textField: 'display',
                            valueField: 'value',
                            filterable: true,
                            required: true,
                            value: null,
                            onSaved: (value) {
                              print('The value is $value');
                            },
                            change: (value) {
                              print('The value is $value');
                            },
                            selectIcon: Icons.arrow_drop_down_circle,
                            saveButtonColor: AppColors.primaryColor,
                            checkBoxColor: AppColors.primaryColor,
                            cancelButtonColor: AppColors.primaryColor,
                            // dataSource: [
                            //   {
                            //     "display": "User 1",
                            //     "value": "User 1",
                            //   },
                            //   {
                            //     "display": "User 2",
                            //     "value": "User 2",
                            //   },
                            //   {
                            //     "display": "User 3",
                            //     "value": "User 3",
                            //   }
                            // ],
                          )),

                      const SizedBox(
                        height: 10,
                      ),
                      //Create Group Button

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
