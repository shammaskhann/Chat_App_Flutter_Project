import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';
import 'package:flutter_firebase_project_app/view/Home_View/Drawer/drawer.dart';
import 'package:flutter_firebase_project_app/view/Widgets/MessengerTile.dart';

import '../../Utils/utils.dart';
import '../../constant/routes.dart';
import '../Widgets/ChatroomTile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChatServices _chatServices = ChatServices();
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
                  onChanged: (value) {},
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
                  Text('Chatrooms', style: AppTextStyle.heading),
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
                            return MessengerTile(
                              uid: snapshot.data.docs[index]['uid'],
                              name: snapshot.data.docs[index]['name'],
                            );
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
    );
  }
}
