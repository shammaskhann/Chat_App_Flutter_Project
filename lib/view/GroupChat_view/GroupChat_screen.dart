import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/Utils/utils.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
import 'package:flutter_firebase_project_app/controllers/GroupController/GroupController.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/ImageChatWidet.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/MessageChatWidget.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/PopUpMenu.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/VoiceNoteChatWidet.dart';
import 'package:flutter_firebase_project_app/view/GroupChat_view/widget/GroupChatMessageWidget.dart';
import 'package:flutter_firebase_project_app/view/VideoCall_view/videocall_screen.dart';

class GroupChatScreen extends StatefulWidget {
  final Map group;
  const GroupChatScreen({required this.group, super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  GroupController groupController = GroupController();
  ChatController chatController = ChatController();
  final _messageController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.group['groupImage']),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.group['name'],
                      style: AppTextStyle.heading.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.07)),
                  Expanded(child: Container()),
                  // IconButton(
                  //   icon: Icon(Icons.video_call),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => VideoCallScreen()));
                  //   },
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: chatController
                        .getStreamGroupMessage(widget.group['name']),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshots.hasData) {
                        final user = FirebaseAuth.instance.currentUser;
                        final reversedMessages =
                            snapshots.data!.docs.reversed.toList();
                        return ListView.builder(
                            reverse: true,
                            itemCount: reversedMessages.length,
                            itemBuilder: (context, index) {
                              // final isSeen = reversedMessages[index]['isSeen'];
                              final message =
                                  reversedMessages[index]['message'];
                              final senderUid =
                                  reversedMessages[index]['senderUid'];
                              final messageID = reversedMessages[index].id;
                              final isMyMessage = reversedMessages[index]
                                      ['senderUid'] ==
                                  user!.uid;
                              final timestamp =
                                  reversedMessages[index]['timestamp'];
                              final isMedia =
                                  reversedMessages[index]['isMedia'];
                              final dateTime =
                                  (timestamp != null && timestamp is Timestamp)
                                      ? timestamp.toDate()
                                      : DateTime.now();
                              String mediaUrl = message;
                              if (isMedia) {
                                if (mediaUrl.contains(".mp3")) {
                                  try {
                                    return VoiceNoteChatWidget(
                                      dateTime: dateTime,
                                      isMyMessage: isMyMessage,
                                      mediaUrl: mediaUrl,
                                    );
                                  } catch (e) {
                                    Utils.toastMessage(e.toString());
                                  }
                                  ;
                                } else {
                                  return ImageChatWidget(
                                      dateTime: dateTime,
                                      isMyMessage: isMyMessage,
                                      message: message,
                                      isSeen: false);
                                }
                              }
                              return MessageGroupChatWidget(
                                  messageID: messageID,
                                  dateTime: dateTime,
                                  isMyMessage: isMyMessage,
                                  message: message,
                                  isSeen: false,
                                  group: widget.group,
                                  senderUid: senderUid);
                            });
                      }
                      return Center(child: Text('No Messages'));
                    }),
              ),
              const SizedBox(
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
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
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
                          onPressed: () {
                            if (_messageController.text.isEmpty) {
                              return;
                            } else {
                              // print('Send Button Pressed Reciever${widget.uid}');
                              chatController.sendGroupMessages(
                                  widget.group['name'],
                                  user!.uid,
                                  _messageController.text);
                              // _chatController.sendMessage(
                              //     widget.uid, _messageController.text);
                              _messageController.clear();
                            }
                          },
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
                    child: MediaPopUpMenu(uid: user!.uid),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
