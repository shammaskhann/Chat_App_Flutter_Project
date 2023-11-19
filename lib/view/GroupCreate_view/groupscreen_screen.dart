import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/GroupController/GroupController.dart';
import 'package:flutter_firebase_project_app/controllers/SearchController/searchController.dart';
import 'package:flutter_firebase_project_app/services/Chat_services/chat_services.dart';
import 'package:flutter_firebase_project_app/view/Home_View/home_screen.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import '../../Utils/utils.dart';
import '../Widgets/CustomWideButton.dart';

class GroupCreateScreen extends StatefulWidget {
  final String groupName;
  final String groupDescription;
  final File groupAvatarImage;
  const GroupCreateScreen(
      {required this.groupName,
      required this.groupDescription,
      required this.groupAvatarImage,
      super.key});

  @override
  State<GroupCreateScreen> createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  final user = FirebaseAuth.instance.currentUser;
  ChatServices _chatServices = ChatServices();
  FloatingSearchBarController controller = FloatingSearchBarController();
  Searchcontroller searchController = Searchcontroller();
  GroupController _groupController = GroupController();
  List<Map> selectedUsers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ADD MEMBERS", style: AppTextStyle.heading),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
          ),
        ),
      ),
      body: SafeArea(
        //Messenging App
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected Member',
                          style: AppTextStyle.heading),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: selectedUsers.length,
                          itemBuilder: (context, index) {
                            try {
                              return FocusedMenuHolder(
                                blurSize: 10.0,
                                menuOffset: 10.0,
                                animateMenuItems: true,
                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.50,
                                openWithTap: true,
                                menuItems: <FocusedMenuItem>[
                                  FocusedMenuItem(
                                    title: Text("Remove"),
                                    trailingIcon: Icon(Icons.remove),
                                    onPressed: () async {
                                      selectedUsers.removeAt(index);
                                      setState(() {});
                                    },
                                  ),
                                ],
                                onPressed: () {},
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.luminousGreen,
                                    child: Text(
                                      selectedUsers[index]['name'][0],
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    selectedUsers[index]['name'],
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              log('error :$e');
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              child: FloatingSearchBar(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  controller: controller,
                  queryStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  hintStyle: AppTextStyle.subtitle,
                  hint: 'Search...',
                  transitionDuration: const Duration(milliseconds: 800),
                  transitionCurve: Curves.easeInOutCubic,
                  physics: const BouncingScrollPhysics(),
                  axisAlignment: 0.0,
                  openAxisAlignment: 0.0,
                  backgroundColor: AppColors.white,
                  progress: false,
                  actions: [
                    FloatingSearchBarAction.searchToClear(
                      showIfClosed: false,
                    ),
                  ],
                  debounceDelay: const Duration(milliseconds: 500),
                  onQueryChanged: (query) async {
                    await searchController.searchUser(query);
                    setState(() {});
                  },
                  closeOnBackdropTap: true,
                  clearQueryOnClose: true,
                  builder: ((context, transition) {
                    return buildSearchResults();
                  })),
            ),
            Positioned(
              bottom: 0,
              right: 15,
              left: 15,
              child: CustomButton(
                  title: "CREATE GROUP",
                  loading: false,
                  onPressed: () {
                    _groupController.createGroup(
                        selectedUsers,
                        widget.groupName,
                        widget.groupDescription,
                        widget.groupAvatarImage);
                    Utils.toastMessage('Group Created');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }));
                  }),
            )
          ],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }

  Widget buildSearchResults() {
    return FutureBuilder(
      future: searchController.searchUser(controller.query),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          int itemCount = snapshot.data!.docs.length;
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            height: itemCount * 60.0,
            child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (user!.uid == snapshot.data.docs[index]['uid']) {
                    for (int i = 0; i < selectedUsers.length; i++) {
                      if (selectedUsers[i]['uid'] ==
                          snapshot.data.docs[index]['uid']) {
                        Utils.toastMessage('User Already Added');
                        return const SizedBox();
                      }
                    }
                    selectedUsers.add(snapshot.data.docs[index].data());
                  }
                  if (user!.uid != snapshot.data.docs[index]['uid']) {
                    return InkWell(
                      onTap: () {
                        for (int i = 0; i < selectedUsers.length; i++) {
                          if (selectedUsers[i]['uid'] ==
                              snapshot.data.docs[index]['uid']) {
                            Utils.toastMessage('User Already Added');
                            return;
                          }
                        }
                        selectedUsers.add(snapshot.data.docs[index].data());
                        Utils.toastMessage('User Added');
                        log(selectedUsers.toString());
                        controller.query = '';
                        controller.close();
                        setState(() {});
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.luminousGreen,
                          child: Text(
                            snapshot.data.docs[index]['name'][0],
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          snapshot.data.docs[index]['name'],
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          );
        }
        return const Center(
          child: Text(
            'No User Found',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
