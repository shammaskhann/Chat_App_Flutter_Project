import 'dart:developer';

import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../../constant/colors.dart';
import '../../controllers/VoiceNoteController/voicenote_controller.dart';

class VoiceRecBottomSheet extends StatefulWidget {
  final String uid;
  const VoiceRecBottomSheet({required this.uid, Key? key}) : super(key: key);

  @override
  State<VoiceRecBottomSheet> createState() => _VoiceRecBottomSheetState();
}

class _VoiceRecBottomSheetState extends State<VoiceRecBottomSheet> {
  final VoiceNoteController _voiceNoteController = VoiceNoteController();

  bool isRecording = false;
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: InkWell(
          onTap: () async {
            if (isProcessing == false) {
              if (!isRecording) {
                await _voiceNoteController.startRecording();
                Utils.toastMessage('Recording Started');
                setState(() {
                  isRecording = true;
                });
              } else {
                setState(() {
                  isRecording = false;
                  isProcessing = true;
                });
                log('Recording Stopped');
                await _voiceNoteController.stopRecording(widget.uid);
                setState(() {
                  isProcessing = false;
                });
                Utils.toastMessage('Recording Sent');
                Navigator.pop(context);
              }
            } else {
              Utils.toastMessage(
                  'Please wait for the previous recording to finish');
            }
          },
          child: (isProcessing)
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.luminousGreen,
                )
              : Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: (!isRecording)
                          ? AppColors.luminousGreen
                          : AppColors.errorRed,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (!isRecording) ? Icons.mic : Icons.stop_circle_outlined,
                        color: (!isRecording)
                            ? AppColors.luminousGreen
                            : AppColors.errorRed,
                      ),
                      Text(
                        (!isRecording) ? 'Record' : 'Stop',
                        style: TextStyle(
                          color: (!isRecording)
                              ? AppColors.luminousGreen
                              : AppColors.errorRed,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
