import 'package:fishnetlk/core/constants/extensions.dart';
import 'package:fishnetlk/core/screens/error_screen.dart';
import 'package:fishnetlk/core/screens/loader.dart';
// import 'package:fishnetlk/features/chat/presentation/widgets/chat_tile.dart';
// import 'package:fishnetlk/features/chat/providers/get_all_chats_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/get_all_chats_provider.dart';
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
