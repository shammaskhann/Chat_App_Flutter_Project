import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';
import 'package:image_picker/image_picker.dart';

class ChatController {
  final auth = FirebaseAuth.instance;

  final ChatServices _chatServices = ChatServices();

  sendMessage(String senderUid, String message) async {
    final user = auth.currentUser;
    String chatDocumentId = '${user!.uid}_${senderUid}';
    log('chatDocumentId: $chatDocumentId');
    _chatServices.sendMessage(
      chatDocumentId,
      message,
      senderUid,
    );
    String chatDocumentId2 = '${senderUid}_${user.uid}';
    log('chatDocumentId2: $chatDocumentId2');
    _chatServices.sendMessage(
      chatDocumentId2,
      message,
      senderUid,
    );
  }

  getMessages(String senderUid) {
    final user = auth.currentUser;
    String chatDocumentId = '${user!.uid}_${senderUid}';
    log('Fetching Messages from Stream as chatDocumentId: $chatDocumentId');
    return _chatServices.getChatMessagesStream(chatDocumentId);
  }

  uploadMedia(String senderUid, ImageSource what) async {
    final ChatServices _chatServices = ChatServices();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    String chatDocumentId = '${user!.uid}_${senderUid}';
    log('chatDocumentId: $chatDocumentId');
    final chatId = chatDocumentId;
    String chatDocumentId2 = '${senderUid}_${user.uid}';
    log('chatDocumentId2: $chatDocumentId2');
    final chatId2 = chatDocumentId2;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: what);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('chat_media')
          .child(chatId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(file);
      final mediaUrl = await storageReference.getDownloadURL();
      _chatServices.sendMessage(
        chatId,
        mediaUrl,
        senderUid,
        isMedia: true,
      );
      _chatServices.sendMessage(
        chatId2,
        mediaUrl,
        senderUid,
        isMedia: true,
      );
    }
  }

  uploadVideo(String senderUid, ImageSource what) async {
    ChatServices _chatServices = ChatServices();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    String chatDocumentId = '${user!.uid}_${senderUid}';
    log('chatDocumentId: $chatDocumentId');
    final chatId = chatDocumentId;
    String chatDocumentId2 = '${senderUid}_${user.uid}';
    log('chatDocumentId2: $chatDocumentId2');
    final chatId2 = chatDocumentId2;
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: what);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('chat_media')
          .child(chatId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(file);
      final mediaUrl = await storageReference.getDownloadURL();
      _chatServices.sendMessage(
        chatId,
        mediaUrl,
        senderUid,
        isMedia: true,
      );
      _chatServices.sendMessage(
        chatId2,
        mediaUrl,
        senderUid,
        isMedia: true,
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> lastMessege(String recieverUID) {
    final user = auth.currentUser;
    String chatDocumentId = '${user!.uid}_${recieverUID}';
    log('chatDocumentId: $chatDocumentId');
    return _chatServices.lastMessage(chatDocumentId);
  }

  markChatAsReadn(String chatdocumentid) {
    final user = auth.currentUser;
    String chatDocumentId = '${chatdocumentid}_${user!.uid}';
    log('Marking As Seen Msg of chatDocumentId: $chatDocumentId');
    return _chatServices.markChatAsRead(chatDocumentId);
  }

  noOfNewMessage(String chatdocumentid) {
    final user = auth.currentUser;
    String chatDocumentId = '${chatdocumentid}_${user!.uid}';
    log('Check No Of New Messages chatDocumentId: $chatDocumentId');
    return _chatServices.noOfNewMessages(chatDocumentId);
  }
}
