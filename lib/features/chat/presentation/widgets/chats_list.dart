import 'package:flutter/material.dart';
import 'chat_tile.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});
  @override
  Widget build(BuildContext context) {
    return ChatTile(
      userId: 'userId',
      lastMessage: 'chat.lastMessage',
      lastMessageTs: DateTime(2017, 9, 7, 17, 30),
      chatroomId: 'chat.chatroomId',
    );
  }
}
