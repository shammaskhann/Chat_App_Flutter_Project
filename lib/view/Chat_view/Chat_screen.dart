import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/models/UserInfo_services/userinfo_services.dart';

import '../../models/RecieverInfo_services/recieverinfo_services.dart';

class ChatScreen extends StatefulWidget {
  final String uid;
  const ChatScreen({required this.uid, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  RecieverInfoServices _recieverInfoServices = RecieverInfoServices();
  AvatarController _avatarController = AvatarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: _avatarController.getAvatar(widget.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(snapshot.data.toString()),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      );
                    }
                    return const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                FutureBuilder(
                    future: _recieverInfoServices.getName(widget.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          snapshot.data.toString(),
                          style: AppTextStyle.heading
                              .copyWith(color: AppColors.white),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: AppTextStyle.heading
                              .copyWith(color: AppColors.white),
                        );
                      }
                      return Text(
                        'Loading...',
                        style: AppTextStyle.heading
                            .copyWith(color: AppColors.white),
                      );
                    })
              ],
            ),
            Spacer(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.78,
                  decoration: BoxDecoration(
                    color: const Color(0xFF596787),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a message',
                          hintStyle: TextStyle(
                            fontFamily: 'Mont',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.luminousGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.luminousGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
