import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_project_app/controllers/ChatController/chat_controller.dart';
import 'package:flutter_firebase_project_app/services/FireStorage_services/ImageStorage_services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../../../constant/colors.dart';

class MessageGroupChatWidget extends StatefulWidget {
  final String messageID;
  final dateTime;
  final bool isMyMessage;
  final String message;
  final bool isSeen;
  final Map group;
  final String senderUid;
  const MessageGroupChatWidget(
      {required this.dateTime,
      required this.messageID,
      required this.isMyMessage,
      required this.message,
      required this.isSeen,
      required this.group,
      required this.senderUid,
      super.key});

  @override
  State<MessageGroupChatWidget> createState() => _MessageGroupChatWidgetState();
}

class _MessageGroupChatWidgetState extends State<MessageGroupChatWidget> {
  String SenderName = '';
  var image = Image.network('');
  CloudImageServices cloudImageServices = CloudImageServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.group['users'].length; i++) {
      if (widget.group['users'][i]['uid'] == widget.senderUid) {
        SenderName = widget.group['users'][i]['name'];
        // image = Image.network(url);
        //image = Image.network(widget.group['users'][i]['image']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ChatController _chatController = ChatController();
    return (widget.isMyMessage)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: widget.isMyMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Text(
                //   '${widget.dateTime.hour}:${widget.dateTime.minute}',
                //   style: const TextStyle(
                //     color: Colors.grey,
                //     fontSize: 12,
                //   ),
                // ),

                FocusedMenuHolder(
                  blurSize: 2.0,
                  menuOffset: 10.0,
                  animateMenuItems: true,
                  menuWidth: MediaQuery.of(context).size.width * 0.50,
                  openWithTap: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.isMyMessage
                          ? const Color(0xFF272A35)
                          : const Color(0xFF373E4E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.isMyMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  menuItems: [
                    FocusedMenuItem(
                      title: Text("Copy"),
                      trailingIcon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.message));
                      },
                    ),
                    FocusedMenuItem(
                      title: Text("Delete For Me"),
                      trailingIcon: Icon(Icons.delete),
                      onPressed: () {
                        //_chatController.deleteMessage(widget.messageID);
                      },
                    ),
                    FocusedMenuItem(
                      title: Text("Delete For Everyone"),
                      trailingIcon: Icon(Icons.delete_forever),
                      onPressed: () {},
                    ),
                  ],
                ),
                (widget.isMyMessage)
                    ? (widget.isSeen)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Seen',
                                style:
                                    TextStyle(color: AppColors.luminousGreen),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.done_all,
                                color: AppColors.luminousGreen,
                                size: 15,
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Sent',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.done_all,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          )
                    : const SizedBox(),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: widget.isMyMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.dateTime.hour}:${widget.dateTime.minute}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  SenderName,
                  style: TextStyle(
                    color: (widget.senderUid == widget.group['users'][0]['uid'])
                        ? AppColors.luminousGreen
                        : (widget.senderUid == widget.group['users'][1]['uid'])
                            ? AppColors.asteroidOrange
                            : AppColors.electricBlue,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FocusedMenuHolder(
                  blurSize: 2.0,
                  menuOffset: 10.0,
                  animateMenuItems: true,
                  menuWidth: MediaQuery.of(context).size.width * 0.50,
                  openWithTap: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.isMyMessage
                          ? const Color(0xFF272A35)
                          : const Color(0xFF373E4E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.isMyMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  menuItems: [
                    FocusedMenuItem(
                      title: Text("Copy"),
                      trailingIcon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.message));
                      },
                    ),
                    FocusedMenuItem(
                      title: Text("Delete For Me"),
                      trailingIcon: Icon(Icons.delete),
                      onPressed: () {
                        //_chatController.deleteMessage(widget.messageID);
                      },
                    ),
                    FocusedMenuItem(
                      title: Text("Delete For Everyone"),
                      trailingIcon: Icon(Icons.delete_forever),
                      onPressed: () {},
                    ),
                  ],
                ),
                (widget.isMyMessage)
                    ? (widget.isSeen)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Seen',
                                style:
                                    TextStyle(color: AppColors.luminousGreen),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.done_all,
                                color: AppColors.luminousGreen,
                                size: 15,
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Sent',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.done_all,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          )
                    : const SizedBox(),
              ],
            ),
          );
  }
}
