import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class VoiceNoteChatWidget extends StatefulWidget {
  final dateTime;
  final bool isMyMessage;
  final String mediaUrl;
  const VoiceNoteChatWidget(
      {required this.dateTime,
      required this.isMyMessage,
      required this.mediaUrl,
      super.key});

  @override
  State<VoiceNoteChatWidget> createState() => _VoiceNoteChatWidgetState();
}

class _VoiceNoteChatWidgetState extends State<VoiceNoteChatWidget> {
  @override
  Widget build(BuildContext context) {
    final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
    return Padding(
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
                IconButton(
                    onPressed: () {
                      _assetsAudioPlayer.open(
                        Audio.network(widget.mediaUrl),
                        autoStart: true,
                        showNotification: true,
                      );
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    )),
                const Spacer(),
                const Text(
                  "00:00",
                  style: TextStyle(color: Colors.white),
                ),
              ])),
        ],
      ),
    );
  }
}
