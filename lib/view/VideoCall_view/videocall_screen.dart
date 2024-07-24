// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_project_app/constant/colors.dart';

// class VideoCallScreen extends StatefulWidget {
//   const VideoCallScreen({super.key});

//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: 'f2786ded096b47fd9cc38eeb7a1bccef',
//       channelName: 'fluttering',
//       tempToken:
//           '007eJxTYJA0TNPgVT169YXz9OVazCkVpxn/WCXVKX/q/Bt99OSln6cUGNKMzC3MUlJTDCzNkkzM01Isk5ONLVJTk8wTDZOSk1PTHhlGpTYEMjJEVpkyMEIhiM/FkJZTWlKSWpSZl87AAAA43yMU',
//     ),
//   );
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _initAgora();
//   }

//   Future<void> _initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.primaryColor,
//             title: const Text('Video Call'),
//             centerTitle: true,
//           ),
//           body: SafeArea(
//               child: Stack(children: [
//             AgoraVideoViewer(
//               client: client,
//               layoutType: Layout.floating,
//               showNumberOfUsers: true,
//             ),
//             AgoraVideoButtons(
//               client: client,
//               enabledButtons: [
//                 BuiltInButtons.toggleCamera,
//                 BuiltInButtons.toggleMic,
//                 BuiltInButtons.callEnd,
//               ],
//             )
//           ]))),
//     );
//   }
// }
