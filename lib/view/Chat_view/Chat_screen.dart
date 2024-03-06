import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/Utils/utils.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_firebase_project_app/constant/textstyle.dart';
import 'package:flutter_firebase_project_app/controllers/AvatarControllor/avatar_controller.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/ImageChatWidet.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/MessageChatWidget.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/PopUpMenu.dart';
import 'package:flutter_firebase_project_app/view/Chat_view/widgets/VoiceNoteChatWidet.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/RecieverInfo_services/recieverinfo_services.dart';

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
  final user = FirebaseAuth.instance.currentUser;
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
                          style: AppTextStyle.heading.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07),
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
                    //snapshot.data!.docs[0].reference.update({'isRead': true});
                    final reversedMessages =
                        snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                      reverse: true,
                      itemCount: reversedMessages.length,
                      itemBuilder: (context, index) {
                        final message = reversedMessages[index]['message'];
                        final senderUid = reversedMessages[index]['senderUid'];
                        final messageID = reversedMessages[index].id;
                        final isMyMessage =
                            reversedMessages[index]['senderUid'] == widget.uid;
                        final timestamp = reversedMessages[index]['timestamp'];
                        final isMedia = reversedMessages[index]['isMedia'];
                        final isSeen = reversedMessages[index]['isRead'];
                        final dateTime =
                            (timestamp != null && timestamp is Timestamp)
                                ? timestamp.toDate()
                                : DateTime.now();
                        if (!isMyMessage) {
                          // log('currentUser : ${user!.uid}');
                          // log('marking as read of senderUid: $senderUid to recieverUid: ${widget.uid.toString()}');
                          _chatController.markChatAsReadn(widget.uid);
                          // snapshot.data!.docs[index].reference.update({
                          //   'isRead': true,
                          // });
                        }
                        // log('isMedia: $isMedia');
                        String mediaUrl = message;
                        if (isMedia) {
                          if (mediaUrl.contains(".mp3")) {
                            try {
                              return VoiceNoteChatWidget(
                                  dateTime: dateTime,
                                  isMyMessage: isMyMessage,
                                  mediaUrl: mediaUrl);
                            } catch (e) {
                              Utils.toastMessage(e.toString());
                            }
                            ;
                          } else {
                            // log("mediaUrl: $mediaUrl");
                            // log("Accesing Image Viewer");
                            return Row(
                              mainAxisAlignment: isMyMessage
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                ImageChatWidget(
                                    dateTime: dateTime,
                                    isMyMessage: isMyMessage,
                                    message: message,
                                    isSeen: isSeen),
                                (isMyMessage)
                                    ? const SizedBox()
                                    : IconButton(
                                        onPressed: () async {
                                          var dio = Dio();
                                          try {
                                            var tempDir =
                                                await getTemporaryDirectory();
                                            var tempFilePath =
                                                '${tempDir.path}/tempImage.jpg';
                                            await dio
                                                .download(message, tempFilePath,
                                                    onReceiveProgress:
                                                        (rec, total) {
                                              print(
                                                  'Rec: $rec , Total: $total');
                                            });
                                            print('Download completed');

                                            // Save the image to the gallery
                                            GallerySaver.saveImage(tempFilePath,
                                                    albumName: 'Download')
                                                .then((bool? success) {
                                              print(
                                                  'Image saved to gallery: $success');
                                            });
                                            Utils.toastMessage(
                                                'Image saved to gallery');
                                          } catch (e) {
                                            print('Download error: $e');
                                          }
                                        },
                                        icon: const Icon(Icons.download),
                                      ),
                              ],
                            );
                          }
                        }
                        return MessageChatWidget(
                            messageID: messageID,
                            dateTime: dateTime,
                            isMyMessage: isMyMessage,
                            message: message,
                            isSeen: isSeen);
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
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
                  child: MediaPopUpMenu(uid: widget.uid),
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
