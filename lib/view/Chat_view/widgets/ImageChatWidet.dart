import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/colors.dart';

class ImageChatWidget extends StatefulWidget {
  final dateTime;
  final bool isMyMessage;
  final String message;
  final bool isSeen;
  const ImageChatWidget(
      {required this.dateTime,
      required this.isMyMessage,
      required this.message,
      required this.isSeen,
      super.key});

  @override
  State<ImageChatWidget> createState() => _ImageChatWidgetState();
}

class _ImageChatWidgetState extends State<ImageChatWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Image.network(widget.message),
              ),
            ),
          ),
        );
      },
      child: GestureDetector(
        onLongPress: () {},
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
                decoration: BoxDecoration(
                  color: widget.isMyMessage
                      ? const Color(0xFF272A35)
                      : const Color(0xFF373E4E),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.network(widget.message, width: 200, height: 200,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    width: 200,
                    height: 200,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.black26,
                      ),
                    ),
                  );
                }),
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
        ),
      ),
    );
  }
}
