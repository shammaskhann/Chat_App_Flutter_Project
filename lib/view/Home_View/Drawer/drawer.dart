import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/services/UserInfo_services/userinfo_services.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Utils/utils.dart';
import '../../../constant/colors.dart';
import '../../../constant/routes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoServices userInfoServices = UserInfoServices();
    return Drawer(
      backgroundColor: AppColors.silverGray,
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: userInfoServices.getUserAvatar(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(snapshot.data),
                          );
                        } else {
                          return Shimmer.fromColors(
                            baseColor: AppColors.luminousGreen,
                            highlightColor: AppColors.glowingCyan,
                            child: const CircleAvatar(
                              radius: 40,
                            ),
                          );
                        }
                      })),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: userInfoServices.getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data,
                          style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.luminousGreen),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, AppRoutes.loginScreen);
              Utils.toastMessage("Logout");
            },
          ),
        ],
      ),
    );
  }
}
