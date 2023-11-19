import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_project_app/Utils/utils.dart';
import 'package:flutter_firebase_project_app/services/Chat_services/chat_services.dart';
import 'package:record/record.dart'; // Import the record package
import 'package:permission_handler/permission_handler.dart';

class VoiceNoteController {
  final ChatServices _chatServices = ChatServices();
  final auth = FirebaseAuth.instance;
  final Record _record = Record();

  Future<void> startRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      try {
        // Start recording
        await _record.start();
        log('Recording started');
      } catch (e) {
        Utils.toastMessage('Error starting recording: $e');
      }
    } else if (status.isDenied) {
      Utils.toastMessage('Microphone permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> stopRecording(String senderUid) async {
    String? _recordingpath;
    final user = auth.currentUser;

    try {
      // Stop recording
      _recordingpath = await _record.stop();
      log('Recording stopped');
    } catch (e) {
      Utils.toastMessage('Error stopping recording: $e');
    }

    if (_recordingpath != null) {
      log("Recording path: $_recordingpath");
      String chatDocumentId = '${user!.uid}_${senderUid}';
      log('chatDocumentId: $chatDocumentId');
      final chatId = chatDocumentId;
      String chatDocumentId2 = '${senderUid}_${user.uid}';
      log('chatDocumentId2: $chatDocumentId2');
      final chatId2 = chatDocumentId2;
      log('chatId: $chatId');
      log('chatId2: $chatId2');
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('chat_media')
          .child(chatId)
          .child('${DateTime.now().millisecondsSinceEpoch}.mp3');

      try {
        await storageReference.putFile(File(_recordingpath));
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
      } catch (e) {
        Utils.toastMessage(e.toString());
      }
    } else {
      Utils.toastMessage('No recording found');
    }
  }
}

// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_firebase_project_app/Utils/utils.dart';
// import 'package:flutter_firebase_project_app/models/Chat_services/chat_services.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VoiceNoteController {
//   final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
//   final ChatServices _chatServices = ChatServices();
//   final auth = FirebaseAuth.instance;

//   Future<void> startRecording() async {
//     final status = await Permission.microphone.request();

//     if (status.isGranted) {
//       await _soundRecorder.openRecorder();
//       try {
//         // Open an audio session before recordind
//         await _soundRecorder.startRecorder(
//             toFile: 'voice_note.mp3', codec: Codec.opusOGG);
//       } catch (e) {
//         Utils.toastMessage('Error starting recording: $e');
//       }
//     } else if (status.isDenied) {
//       Utils.toastMessage('Microphone permission denied');
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }

//   Future<void> stopRecording(String senderUid) async {
//     final user = auth.currentUser;
//     await _soundRecorder.stopRecorder();
//     final recordingPath = await _soundRecorder.stopRecorder();
//     String chatDocumentId = '${user!.uid}_${senderUid}';
//     log('chatDocumentId: $chatDocumentId');
//     final chatId = chatDocumentId;
//     String chatDocumentId2 = '${senderUid}_${user.uid}';
//     log('chatDocumentId2: $chatDocumentId2');
//     final chatId2 = chatDocumentId2;
//     final storageReference = FirebaseStorage.instance
//         .ref()
//         .child('chat_media')
//         .child(chatId)
//         .child('${DateTime.now().millisecondsSinceEpoch}.mp3');
//     if (recordingPath != null) {
//       try {
//         await storageReference.putFile(File(recordingPath));
//       } catch (e) {
//         Utils.toastMessage(e.toString());
//       }
//       final mediaUrl = await storageReference.getDownloadURL();
//       _chatServices.sendMessage(
//         chatId,
//         mediaUrl,
//         senderUid,
//         isMedia: true,
//       );
//       _chatServices.sendMessage(
//         chatId2,
//         mediaUrl,
//         senderUid,
//         isMedia: true,
//       );
//     } else {
//       Utils.toastMessage('No recording found');
//     }
//   }
// }
