import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceNotePlayerWidget extends StatefulWidget {
  final String audioUrl;
  const VoiceNotePlayerWidget({required this.audioUrl, Key? key})
      : super(key: key);

  @override
  _VoiceNotePlayerWidgetState createState() => _VoiceNotePlayerWidgetState();
}

class _VoiceNotePlayerWidgetState extends State<VoiceNotePlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged;
    _audioPlayer.onPlayerComplete.listen((event) {
      // Handle audio completion if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _audioPlayer.play(UrlSource(
          widget.audioUrl,
        ));
      },
      icon: Icon(Icons.play_arrow),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }
}
