import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  // Replace 'yourCollectionName' with the name you want to use.
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
      'isMedia': isMedia, // Add this flag to indicate if it's media
    });
  }

// Function to listen for new messages in a chat
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
  //     // Return an empty stream if the document does not exist
  //     yield* Stream.empty();
  //   }
  // }
}
