import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/routes.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
import 'package:flutter_firebase_project_app/controllers/VoiceNoteController/voicenote_controller.dart';
import 'package:flutter_firebase_project_app/view/Widgets/VoiceRecordingWidget.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/colors.dart';

class MediaPopUpMenu extends StatefulWidget {
  final String uid;
  const MediaPopUpMenu({required this.uid, super.key});

  @override
  State<MediaPopUpMenu> createState() => _MediaPopUpMenuState();
}

class _MediaPopUpMenuState extends State<MediaPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    ChatController _chatController = ChatController();
    return FocusedMenuHolder(
      blurSize: 5.0,
      menuOffset: 10.0,
      animateMenuItems: true,
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      openWithTap: true,
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          title: Text("Take Photo"),
          trailingIcon: Icon(Icons.camera_alt),
          onPressed: () async {
            await _chatController.uploadMedia(widget.uid, ImageSource.camera);
          },
        ),
        FocusedMenuItem(
          title: Text("Upload Gallery"),
          trailingIcon: Icon(Icons.photo_library),
          onPressed: () async {
            await _chatController.uploadMedia(widget.uid, ImageSource.gallery);
          },
        ),
        FocusedMenuItem(
          title: Text("Send Voice"),
          trailingIcon: Icon(Icons.mic),
          onPressed: () {
            //View for recording voice note
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return VoiceRecBottomSheet(uid: widget.uid);
                });
          },
        ),
      ],
      onPressed: () {},
      child: ClipRRect(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.luminousGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
