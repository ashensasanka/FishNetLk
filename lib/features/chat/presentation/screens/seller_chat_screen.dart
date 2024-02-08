import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:fishnetlk/core/screens/loader.dart';
import 'package:fishnetlk/core/utils/utils.dart';
// import 'package:fishnetlk/features/chat/presentation/widgets/chats_user_info.dart';
// import 'package:fishnetlk/features/chat/presentation/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:fishnetlk/features/chat/providers/chat_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../providers/chat_provider.dart';
import '../widgets/chats_user_info.dart';
import '../widgets/messages_list.dart';
import '../widgets/seller_messages_list.dart';

class SellerChatScreen extends ConsumerStatefulWidget {
  const SellerChatScreen({
    super.key,
  });


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SellerChatScreenState();
}

class _SellerChatScreenState extends ConsumerState<SellerChatScreen> {
  late final TextEditingController sellerMessageController;
  late final String chatroomId;

  @override
  void initState() {
    sellerMessageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    sellerMessageController.dispose();
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
        // title: ChatUserInfo(
        //   userId: widget.userId,
        // ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fish_Market_7.jpg'), // Replace 'assets/background_image.jpg' with your image asset path
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        child: Column(

          children: [
            Expanded(
              child: SellerMessagesList(

              ),
            ),
            const Divider(),
            _buildMessageInput(),
          ],
        ),
      ),

    );
    // return FutureBuilder(
    //   future: ref.watch(chatProvider).createChatroom(userId: widget.userId),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Loader();
    //     }
    //
    //     chatroomId = snapshot.data ?? 'No chatroom Id';
    //
    //     return Scaffold(
    //       backgroundColor: AppColors.realWhiteColor,
    //       appBar: AppBar(
    //         leading: IconButton(
    //           onPressed: Navigator.of(context).pop,
    //           icon: const Icon(
    //             Icons.arrow_back_ios,
    //             color: AppColors.messengerBlue,
    //           ),
    //         ),
    //         titleSpacing: 0,
    //         title: ChatUserInfo(
    //           userId: widget.userId,
    //         ),
    //       ),
    //       body: Column(
    //         children: [
    //           Expanded(
    //             child: MessagesList(
    //               chatroomId: chatroomId,
    //             ),
    //           ),
    //           const Divider(),
    //           _buildMessageInput(),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  // Chat Text Field
  Widget _buildMessageInput() {
    return GetBuilder<HomeController>(builder: (ctrl){
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
                // final image = await pickImage();
                // if (image == null) return;
                // await ref.read(chatProvider).sendFileMessage(
                //   file: image,
                //   chatroomId: chatroomId,
                //   receiverId: widget.userId,
                //   messageType: 'image',
                // );
              },
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.video,
                color: AppColors.messengerDarkGrey,
                size: 20,
              ),
              onPressed: () async {
                // final video = await pickVideo();
                // if (video == null) return;
                // await ref.read(chatProvider).sendFileMessage(
                //   file: video,
                //   chatroomId: chatroomId,
                //   receiverId: widget.userId,
                //   messageType: 'video',
                // );
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
                  controller: ctrl.sellerMessageController,
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
                ctrl.addSellerMessage();
                ctrl.fetchSellerMessage();
                // Add functionality to handle send button press
                // await ref.read(chatProvider).sendMessage(
                //   message: messageController.text,
                //   chatroomId: chatroomId,
                //   receiverId: widget.userId,
                // );
                ctrl.sellerMessageController.clear();
              },
            ),
          ],
        ),
      );
    });


  }
}
