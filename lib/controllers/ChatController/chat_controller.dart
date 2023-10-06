import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';
import 'package:image_picker/image_picker.dart';

class ChatController {
  final auth = FirebaseAuth.instance;

  ChatServices _chatServices = ChatServices();

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

  uploadMedia(String senderUid, ImageSource what) async {
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
    final pickedFile = await picker.pickImage(source: what);
    if (pickedFile != null) {
      // Upload the image to Firebase Storage
      final file = File(pickedFile.path);
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('chat_media')
          .child(chatId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(file);
      // Get the URL of the uploaded image
      final mediaUrl = await storageReference.getDownloadURL();
      // Now, you can send the media URL in your chat message along with other details.
      _chatServices.sendMessage(
        chatId,
        mediaUrl,
        senderUid,
        isMedia: true, // Add a flag to indicate that this is media
      );
      _chatServices.sendMessage(
        chatId2,
        mediaUrl,
        senderUid,
        isMedia: true, // Add a flag to indicate that this is media
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
      // Upload the image to Firebase Storage
      final file = File(pickedFile.path);
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('chat_media')
          .child(chatId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageReference.putFile(file);
      // Get the URL of the uploaded image
      final mediaUrl = await storageReference.getDownloadURL();
      // Now, you can send the media URL in your chat message along with other details.
      _chatServices.sendMessage(
        chatId,
        mediaUrl,
        senderUid,
        isMedia: true, // Add a flag to indicate that this is media
      );
      _chatServices.sendMessage(
        chatId2,
        mediaUrl,
        senderUid,
        isMedia: true, // Add a flag to indicate that this is media
      );
    }
  }
}
