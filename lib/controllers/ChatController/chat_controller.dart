import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';

class ChatController {
  final auth = FirebaseAuth.instance;

  ChatServices _chatServices = ChatServices();

  sendMessage(String senderUid, String message) async {
    final user = auth.currentUser;
    String chatDocumentId = '${user!.uid}_${senderUid}';
    log('chatDocumentId: $chatDocumentId');
    _chatServices.sendMessage(chatDocumentId, senderUid, message);
    String chatDocumentId2 = '${senderUid}_${user.uid}';
    log('chatDocumentId2: $chatDocumentId2');
    _chatServices.sendMessage(chatDocumentId2, senderUid, message);
  }

  getMessages(String senderUid) {
    final user = auth.currentUser;
    log('user!.uid: ${user!.uid}');
    log('senderUid: $senderUid');
    log('fetching messages');
    String chatDocumentId = '${user!.uid}_${senderUid}';
    log('chatDocumentId: $chatDocumentId');
    log(_chatServices
        .getChatMessagesStream(chatDocumentId)
        .toString()
        .isEmpty
        .toString());
    return _chatServices.getChatMessagesStream(chatDocumentId);
  }
}
