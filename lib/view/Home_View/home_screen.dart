import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';
import 'package:flutter_firebase_project_app/view/Home_View/Drawer/drawer.dart';
import 'package:flutter_firebase_project_app/view/Home_View/widgets/GroupCreateSheet.dart';
import 'package:flutter_firebase_project_app/view/Widgets/MessengerTile.dart';

import '../../Utils/utils.dart';
import '../../constant/routes.dart';
import '../../controllers/SearchController/searchController.dart';
import '../Widgets/ChatroomTile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List usersList = [];
  final user = FirebaseAuth.instance.currentUser;
  ChatServices _chatServices = ChatServices();
  Searchcontroller _searchController = Searchcontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      body: SafeArea(
        //Messenging App
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchBar(
                  controller: TextEditingController(),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFF596787)),
                  hintText: "Search..",
                  hintStyle: MaterialStateTextStyle.resolveWith(
                    (states) => const TextStyle(
                      fontFamily: 'Mont',
                      color: AppColors.white,
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    maxHeight: 50,
                  ),
                  onChanged: (value) async {
                    usersList = await _searchController.getUsersList();
                    log(usersList.toString());
                  },
                  onTap: () {},
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  trailing: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Chatrooms', style: AppTextStyle.heading),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return ChatroomTile();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: _chatServices.getAllUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            if (user!.uid != snapshot.data.docs[index]['uid']) {
                              return MessengerTile(
                                uid: snapshot.data.docs[index]['uid'],
                                name: snapshot.data.docs[index]['name'],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        backgroundColor: AppColors.luminousGreen,
        onPressed: () {
          showModalBottomSheet(
              transitionAnimationController: AnimationController(
                vsync: Navigator.of(context),
                duration: const Duration(milliseconds: 1000),
              ),
              showDragHandle: true,
              backgroundColor: AppColors.primaryColor,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const GroupCreateSheet();
              });
        },
        child: const Icon(Icons.group_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
