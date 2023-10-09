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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: InkWell(
          onTap: () async {
            if (!isRecording) {
              await _voiceNoteController.startRecording();
              Utils.toastMessage('Recording Started');
              setState(() {
                isRecording = true;
              });
            } else {
              await _voiceNoteController.stopRecording(widget.uid);
              Utils.toastMessage('Recording Stopped');
              setState(() {
                isRecording = false;
              });
            }
          },
          child: Container(
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
