import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  Stream<List<ChatMessage>> MessagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    // Transformando ChatMessage => Map<String, dynamic>
    final docRef = await store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageUrl,
    });
    final doc = await docRef.get();
    final data = doc.data()!;

    // Transformando Map<String, dynamic => ChatMessage >

    Map<String, dynamic> _toFirestore(
      ChatMessage msg,
      SetOptions? options,
    ) {
      return {
        'text': msg.text,
        'createdAt': msg.createdAt.toIso8601String(),
        'userId': msg.userId,
        'userName': msg.userName,
        'userImageUrl': msg.userImageUrl,
      };
    }

    ChatMessage _fromFirestore(
        DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
      return ChatMessage(
          id: doc.id,
          text: doc['text'],
          createdAt: DateTime.parse(doc['createdAt']),
          userId: doc['userId'],
          userName: doc['userName'],
          userImageUrl: doc['userImageUrl']);
    }
  }
}
