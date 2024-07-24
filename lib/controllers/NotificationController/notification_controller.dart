import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/services/Chat_services/chat_services.dart';
import 'package:flutter_firebase_project_app/services/Notification_Services/Notification_Helper.dart';
import 'package:flutter_firebase_project_app/services/UserInfo_services/userinfo_services.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  ChatServices _chatServices = ChatServices();
  NotifyHelper _notifyHelper = NotifyHelper();
  UserInfoServices _userInfoServices = UserInfoServices();
  final user = FirebaseAuth.instance.currentUser;
  String get uid => user!.uid;
  // void produceNotificationFromStream() async {
  //   try {
  //     List<String> ids = await _chatServices.getChatDocumentIDs();
  //     log('ids: $ids');
  //     for (String id in ids) {
  //       _chatServices.getChatMessagesStream(id).listen((event) {
  //         event.docChanges.forEach((element) {
  //           if (element.doc['senderUid'] != uid) {
  //             _notifyHelper.showNotification(
  //                 // title: 'New Message',
  //                 // body: element.doc['message'],
  //                 // chatId: id
  //                 );
  //           }
  //         });
  //       });
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  // }

  String _getMessage(QuerySnapshot snapshot) {
    if (snapshot.docs.isEmpty) {
      return "No message";
    }
    // Explicitly cast the data to Map<String, dynamic>
    var doc = snapshot.docs[0].data() as Map<String, dynamic>;
    bool isMedia = doc['isMedia'];
    String msg = doc['message'];
    if (isMedia) {
      if (msg.contains('.mp3')) {
        return "Voice Note";
      } else {
        return "Photo";
      }
    }
    return msg;
  }

  void activeNotificationForChat(String chatI) {
    String chatId = "${uid}_$chatI";
    log('chatI: $chatI');
    log('uid: $uid');
    log('chatId: $chatId');
    _chatServices.getChatMsgStreamNotifier(chatId).listen((event) {
      event.docChanges.forEach((element) async {
        log('element: ${element.doc['senderUid']}');
        log('element: ${element.doc['message']}');
        log('element: ${element.doc['timestamp']}');
        String name =
            await _userInfoServices.getOtherUserName(element.doc['senderUid']);
        String message = _getMessage(event);
        if (element.doc['senderUid'] == uid && element.doc['isRead'] == false) {
          _notifyHelper.showNotification(
            "Message from $name",
            message,
          );
        }
      });
    });
  }
}
