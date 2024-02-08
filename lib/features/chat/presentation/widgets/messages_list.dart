import 'package:fishnetlk/core/screens/error_screen.dart';
import 'package:fishnetlk/core/screens/loader.dart';
import 'package:fishnetlk/features/chat/presentation/widgets/received_message.dart';
import 'package:fishnetlk/features/chat/presentation/widgets/sent_message.dart';
// import 'package:fishnetlk/features/chat/presentation/widgets/received_message.dart';
// import 'package:fishnetlk/features/chat/presentation/widgets/sent_message.dart';
import 'package:fishnetlk/features/chat/providers/chat_provider.dart';
// import 'package:fishnetlk/features/chat/providers/get_all_messages_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../controller/home_controller.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return ListView.builder(
          reverse: true, // Set reverse to true
          itemCount: ctrl.messageUi.length,
          itemBuilder: (context, index) {
            // Calculate the reversed index
            int reversedIndex = ctrl.messageUi.length - 1 - index;
            return SentMessage(message: ctrl.messageUi[reversedIndex].message as String);
            // You may need to adjust the code based on your actual message structure
          },
        );
      },
    );
  }

}
