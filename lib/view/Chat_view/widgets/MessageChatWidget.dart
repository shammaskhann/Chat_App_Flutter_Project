import 'package:flutter/material.dart';

import '../../../constant/colors.dart';

class MessageChatWidget extends StatefulWidget {
  final dateTime;
  final bool isMyMessage;
  final String message;
  final bool isSeen;
  const MessageChatWidget(
      {required this.dateTime,
      required this.isMyMessage,
      required this.message,
      required this.isSeen,
      super.key});

  @override
  State<MessageChatWidget> createState() => _MessageChatWidgetState();
}

class _MessageChatWidgetState extends State<MessageChatWidget> {
  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
              color: widget.isMyMessage
                  ? const Color(0xFF272A35)
                  : const Color(0xFF373E4E),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.message,
              style: TextStyle(
                color: widget.isMyMessage ? Colors.white : Colors.black,
              ),
            ),
          ),
          (widget.isMyMessage)
              ? (widget.isSeen)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Seen',
                          style: TextStyle(color: AppColors.luminousGreen),
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
              : const SizedBox(),
        ],
      ),
    );
  }
}
