import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';
import 'package:flutter_svg/svg.dart';

class VoiceNoteChatWidget extends StatefulWidget {
  final dateTime;
  bool? isSeen;
  final bool isMyMessage;
  final String mediaUrl;
  VoiceNoteChatWidget(
      {required this.dateTime,
      required this.isMyMessage,
      required this.mediaUrl,
      this.isSeen,
      super.key});

  @override
  State<VoiceNoteChatWidget> createState() => _VoiceNoteChatWidgetState();
}

class _VoiceNoteChatWidgetState extends State<VoiceNoteChatWidget> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  int audioDuration = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: widget.isMyMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.dateTime.hour}:${widget.dateTime.minute}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: widget.isMyMessage
                      ? const Color(0xFF272A35)
                      : const Color(0xFF373E4E),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(children: [
                  (isPlaying)
                      ? IconButton(
                          onPressed: () {
                            _assetsAudioPlayer.pause();
                            setState(() {
                              isPlaying = false;
                            });
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                          ))
                      : IconButton(
                          onPressed: () {
                            _assetsAudioPlayer
                                .open(
                              Audio.network(widget.mediaUrl),
                              autoStart: true,
                              showNotification: true,
                            )
                                .then((value) {
                              setState(() {
                                audioDuration = _assetsAudioPlayer
                                    .current.value!.audio.duration.inSeconds;
                                isPlaying = true;
                              });
                            });
                            _assetsAudioPlayer.realtimePlayingInfos
                                .listen((event) {
                              if (event.currentPosition == event.duration) {
                                setState(() {
                                  isPlaying = false;
                                });
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/Audiowaveform.svg',
                      color: Colors.white,
                      // width: MediaQuery.of(context).size.width * 0.2,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                ])),
            (widget.isSeen != null)
                ? (widget.isMyMessage)
                    ? (widget.isSeen!)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Seen',
                                style:
                                    TextStyle(color: AppColors.luminousGreen),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.done_all,
                                color: AppColors.luminousGreen,
                                size: 15,
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Sent',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.done_all,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          )
                    : const SizedBox()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
