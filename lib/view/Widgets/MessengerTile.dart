import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';

import '../../constant/colors.dart';
import '../../constant/routes.dart';

class MessengerTile extends StatelessWidget {
  final String uid;
  final String name;
  const MessengerTile({required this.uid, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    AvatarController _avatarController = AvatarController();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.chatScreen, arguments: uid);
          },
          child: ListTile(
            leading: FutureBuilder(
              future: _avatarController.getAvatar(uid),
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
            title: Text(
              name,
              style: AppTextStyle.MessageTileName,
            ),
            subtitle: Text(
              "This is the last message",
              style: AppTextStyle.MessageTilesubtitle,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "12:00",
                  style: AppTextStyle.MessageTilesubtitle,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.luminousGreen,
                  child: Text(
                    "2",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
