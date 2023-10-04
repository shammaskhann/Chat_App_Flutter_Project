import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
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
  TextEditingController _messageController = TextEditingController();
  ChatController _chatController = ChatController();
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
                          style: AppTextStyle.heading,
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
            Expanded(
              child: StreamBuilder(
                stream: _chatController.getMessages(widget.uid),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // Reverse the order of messages to start from the bottom
                    final reversedMessages =
                        snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                      reverse: true, // Start from the bottom
                      itemCount: reversedMessages.length,
                      itemBuilder: (context, index) {
                        final message = reversedMessages[index]['message'];
                        final isMyMessage =
                            reversedMessages[index]['senderUid'] == widget.uid;
                        final timestamp = reversedMessages[index]['timestamp'];
                        final dateTime =
                            (timestamp != null && timestamp is Timestamp)
                                ? timestamp.toDate()
                                : DateTime.now();
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: isMyMessage
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dateTime.hour}:${dateTime.minute}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: isMyMessage
                                      ? const Color(0xFF272A35)
                                      : const Color(0xFF373E4E),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    color: isMyMessage
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                // if (snapshot.hasData) {
                //   return ListView.builder(
                //     itemCount: snapshot.data!.docs.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(snapshot.data!.docs[index]['message']),
                //       );
                //     },
                //   );
                // } else {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
              ),
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
                          print('Send Button Pressed Reciever${widget.uid}');
                          _chatController.sendMessage(
                              widget.uid, _messageController.text);
                          _messageController.clear();
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
