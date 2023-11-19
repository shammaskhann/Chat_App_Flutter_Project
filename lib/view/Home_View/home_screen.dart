import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/GroupController/GroupController.dart';
import 'package:flutter_firebase_project_app/services/Chat_services/chat_services.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/Chat_screen.dart';
import 'package:flutter_firebase_project_app/view/GroupCreate_view/groupscreen_screen.dart';
import 'package:flutter_firebase_project_app/view/Home_View/Drawer/drawer.dart';
import 'package:flutter_firebase_project_app/view/Home_View/widgets/GroupModalSheet.dart';
import 'package:flutter_firebase_project_app/view/Widgets/MessengerTile.dart';
import '../../controllers/SearchController/searchController.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import '../Widgets/ChatroomTile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  ChatServices _chatServices = ChatServices();
  FloatingSearchBarController controller = FloatingSearchBarController();
  Searchcontroller searchController = Searchcontroller();
  GroupController groupController = GroupController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const HomeDrawer(),
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
                      const Text('Chatrooms', style: AppTextStyle.heading),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: FutureBuilder(
                          future: groupController.fetchGroups(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.data.docs.length == 0) {
                              return const Center(
                                child: Text(
                                  'No Chatrooms Found',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map groupIndivisual =
                                        snapshot.data.docs[index].data();
                                    for (var i = 0;
                                        i < groupIndivisual['users'].length;
                                        i++) {
                                      if (user!.uid ==
                                          groupIndivisual['users'][i]['uid']) {
                                        return ChatroomTile(
                                          group: groupIndivisual,
                                        );
                                      }
                                    }
                                    return const SizedBox();
                                  });
                            }

                            return const Center(
                              child: Text(
                                'No Chatrooms Found',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
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
                                if (user!.uid !=
                                    snapshot.data.docs[index]['uid']) {
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
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),
              ],
            ),
            FloatingSearchBar(
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
                }))
          ],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        backgroundColor: AppColors.luminousGreen,
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return const GroupCreateScreen();
          // }));
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => GroupCreateModalSheet());
        },
        child: const Icon(Icons.group_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  navigateToMessenger(name, uid) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatScreen(
                uid: uid,
              )),
    );
  }

  // Widget buildSearchResults() {
  //   return SingleChildScrollView(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: AppColors.primaryColor,
  //         borderRadius: BorderRadius.circular(8),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.2),
  //             blurRadius: 6.0,
  //             spreadRadius: 2.0,
  //           ),
  //         ],
  //       ),
  //       height: 250.0,
  //       child: FutureBuilder(
  //         future: searchController.searchUser(controller.query),
  //         builder: (context, AsyncSnapshot snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           }
  //           if (snapshot.hasData) {
  //             return ListView.builder(
  //                 itemCount: snapshot.data!.docs.length,
  //                 itemBuilder: (context, index) {
  //                   if (user!.uid != snapshot.data.docs[index]['uid']) {
  //                     return InkWell(
  //                       onTap: () {
  //                         navigateToMessenger(
  //                           snapshot.data.docs[index]['name'],
  //                           snapshot.data.docs[index]['uid'],
  //                         );
  //                       },
  //                       child: ListTile(
  //                         leading: CircleAvatar(
  //                           backgroundColor: AppColors.luminousGreen,
  //                           child: Text(
  //                             snapshot.data.docs[index]['name'][0],
  //                             style: TextStyle(
  //                               color: AppColors.white,
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                         title: Text(
  //                           snapshot.data.docs[index]['name'],
  //                           style: TextStyle(
  //                             color: AppColors.white,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   } else {
  //                     return const SizedBox();
  //                   }
  //                 });
  //           }
  //           return const Center(
  //             child: Text(
  //               'No User Found',
  //               style: TextStyle(
  //                 color: AppColors.white,
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
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
            height: itemCount *
                60.0, // Adjust this value according to your ListTile height
            child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (user!.uid != snapshot.data.docs[index]['uid']) {
                    return InkWell(
                      onTap: () {
                        navigateToMessenger(
                          snapshot.data.docs[index]['name'],
                          snapshot.data.docs[index]['uid'],
                        );
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
