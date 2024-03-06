import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/routes.dart';

class MessengerTile extends StatelessWidget {
  final String uid;
  final String name;
  const MessengerTile({required this.uid, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    AvatarController _avatarController = AvatarController();
    ChatController _chatController = ChatController();
    var timestamp;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.chatScreen, arguments: uid);
          },
          child: ListTile(
            leading: FutureBuilder(
              future: _avatarController.getAvatar(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(3, 3), // changes position of shadow
                      ),
                    ]),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(snapshot.data.toString()),
                    ),
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
            title: Text(
              name,
              style: AppTextStyle.MessageTileName,
            ),
            subtitle: StreamBuilder(
              stream: _chatController.lastMessege(uid),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    "Loading...",
                    style: AppTextStyle.MessageTilesubtitle,
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Text(
                    "No message",
                    style: AppTextStyle.MessageTilesubtitle,
                  );
                }
                if (snapshot.hasData) {
                  bool isMedia = snapshot.data!.docs[0]['isMedia'];
                  String msg = snapshot.data!.docs[0]['message'];
                  timestamp = snapshot.data!.docs[0]['timestamp'];
                  if (isMedia) {
                    return const Text(
                      "Photo",
                      style: AppTextStyle.MessageTilesubtitle,
                    );
                  }
                  return Text(
                    msg,
                    style: AppTextStyle.MessageTilesubtitle,
                  );
                }
                return const Text(
                  "No message",
                  style: AppTextStyle.MessageTilesubtitle,
                );
              }),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                    stream: _chatController.lastMessege(uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Loading...",
                          style: AppTextStyle.MessageTilesubtitle,
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "",
                          style: AppTextStyle.MessageTilesubtitle,
                        );
                      }
                      if (snapshot.hasData) {
                        timestamp = snapshot.data!.docs[0]['timestamp'];
                        final dateTime =
                            (timestamp != null && timestamp is Timestamp)
                                ? timestamp.toDate()
                                : DateTime.now();
                        final difference = DateTime.now().difference(dateTime);
                        String displayTime;
                        if (difference.inDays == 1) {
                          displayTime = 'Yesterday';
                        } else if (difference.inDays < 7) {
                          displayTime = DateFormat('EEEE')
                              .format(dateTime); // Weekday name
                        } else {
                          displayTime = DateFormat('dd MMM')
                              .format(dateTime); // Date and month
                        }
                        return Text(
                          displayTime,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        );
                      }
                      return const Text(
                        "",
                        style: AppTextStyle.MessageTilesubtitle,
                      );
                    }),
                StreamBuilder(
                    stream: _chatController.noOfNewMessage(uid),
                    builder: (context, AsyncSnapshot snapshot) {
                      int count;
                      count = snapshot.data?.docs.length ?? 0;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Loading...",
                          style: AppTextStyle.MessageTilesubtitle,
                        );
                      }
                      if (count == 0) {
                        return const Text(
                          "",
                          style: AppTextStyle.MessageTilesubtitle,
                        );
                      }
                      if (count > 0) {
                        return CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.luminousGreen,
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const Text(
                        "",
                        style: AppTextStyle.MessageTilesubtitle,
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
