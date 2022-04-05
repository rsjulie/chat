import 'dart:io';

import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBalloon extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBalloon(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);
    if (uri.path.contains('assets/images/avatar')) {
      provider = AssetImage(uri.toString());
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.amber,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
                width: 180,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.only(
                  left: belongsToCurrentUser ? 0 : 52,
                  right: belongsToCurrentUser ? 52 : 0,
                  top: 10,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                    color: belongsToCurrentUser
                        ? Colors.grey.shade300
                        : Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: belongsToCurrentUser
                            ? Radius.circular(12)
                            : Radius.circular(0),
                        bottomRight: !belongsToCurrentUser
                            ? Radius.circular(12)
                            : Radius.circular(0))),
                child: Column(
                  crossAxisAlignment: belongsToCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.userName,
                      style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      message.text,
                      textAlign: belongsToCurrentUser
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                )),
          ],
        ),
        Positioned(
          top: 10,
          left: belongsToCurrentUser ? null : 0,
          right: belongsToCurrentUser ? 0 : null,
          child: _showUserImage(message.userImageUrl),
        ),
      ],
    );
  }
}
