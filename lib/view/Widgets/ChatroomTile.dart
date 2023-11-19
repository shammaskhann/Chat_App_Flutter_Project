import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/view/GroupChat_view/GroupChat_screen.dart';

class ChatroomTile extends StatelessWidget {
  final Map group;
  const ChatroomTile({required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupChatScreen(group: group)));
          },
          child: Container(
            // height: 140,
            width: 105,
            padding: const EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(group['groupImage']),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Text(group['name'],
                        style: AppTextStyle.MessageTileName)),
              ],
            ),
          ),
        ));
  }
}
