import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:fishnetlk/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../providers/chat_provider.dart';
import '../widgets/chats_user_info.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  static const routeName = '/chat-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final TextEditingController messageController;
  late final String chatroomId;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.messengerBlue,
          ),
        ),
        titleSpacing: 0,
        title: ChatUserInfo(
          userId: widget.userId,
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: MessagesList(),
          ),
          const Divider(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Chat Text Field
  Widget _buildMessageInput() {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.image,
                color: AppColors.messengerDarkGrey,
              ),
              onPressed: () async {
                final image = await pickImage();
                if (image == null) return;
                await ref.read(chatProvider).sendFileMessage(
                      file: image,
                      chatroomId: chatroomId,
                      receiverId: widget.userId,
                      messageType: 'image',
                    );
              },
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.video,
                color: AppColors.messengerDarkGrey,
                size: 20,
              ),
              onPressed: () async {
                final video = await pickVideo();
                if (video == null) return;
                await ref.read(chatProvider).sendFileMessage(
                      file: video,
                      chatroomId: chatroomId,
                      receiverId: widget.userId,
                      messageType: 'video',
                    );
              },
            ),
            // Text Field
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.messengerGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: ctrl.messageController,
                  decoration: const InputDecoration(
                    hintText: 'Aa',
                    hintStyle: TextStyle(),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      bottom: 10,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.messengerBlue,
              ),
              onPressed: () {
                ctrl.addMessage(widget.userId);
                ctrl.fetchMessage(widget.userId);
                ctrl.messageController.clear();
              },
            ),
          ],
        ),
      );
    });
  }
}
