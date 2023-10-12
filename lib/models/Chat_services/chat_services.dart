import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');

  Future getAllUser() {
    return _db.collection('users').get();
  }

  // // Function to send a message
  // void sendMessage(String chatId, String senderUid, String message) {
  //   chatCollection.doc(chatId).collection('messages').add({
  //     'senderUid': senderUid,
  //     'message': message,
  //     'timestamp': FieldValue.serverTimestamp(),
  //   });
  // }
  void sendMessage(String chatId, String message, String senderUid,
      {bool isMedia = false}) {
    chatCollection.doc(chatId).collection('messages').add({
      'senderUid': senderUid,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'isMedia': isMedia,
      'isRead': false,
    });
  }

  Stream<QuerySnapshot> getChatMessagesStream(String chatId) {
    return chatCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }
  // Stream<QuerySnapshot> getChatMessagesStream(String chatId) async* {
  //   final docReference = chatCollection.doc(chatId);

  //   final docSnapshot = await docReference.get();

  //   if (docSnapshot.exists) {
  //     yield* docReference
  //         .collection('messages')
  //         .orderBy('timestamp')
  //         .snapshots();
  //   } else {
  //     yield* Stream.empty();
  //   }
  // }
  Stream<QuerySnapshot<Map<String, dynamic>>> lastMessage(
      String chatDocumentID) {
    return chatCollection
        .doc(chatDocumentID)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }
}
