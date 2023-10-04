import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';

class ChatroomTile extends StatelessWidget {
  const ChatroomTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 140,
          width: 105,
          padding: const EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.glowingCyan,
                  AppColors.luminousGreen,
                ],
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Group Name', style: AppTextStyle.MessageTileName),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.white,
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
