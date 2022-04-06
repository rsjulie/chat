import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class newMessage extends StatefulWidget {
  @override
  State<newMessage> createState() => _newMessageState();
}

class _newMessageState extends State<newMessage> {
  String _message = '';
  final _messageController = TextEditingController();
  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;
    if (user != null) {
      final msg = await ChatService().save(_message, user);
      print(msg?.id);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          controller: _messageController,
          onChanged: (msg) => setState(() => _message = msg),
          decoration: InputDecoration(labelText: 'Enviar mensagem...'),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: _message.trim().isEmpty ? null : _sendMessage,
      )
    ]);
  }
}
