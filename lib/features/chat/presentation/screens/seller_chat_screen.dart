import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fish_Market_7.jpg'), // Replace 'assets/background_image.jpg' with your image asset path
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        child: Column(

          children: [
            const Expanded(
              child: SellerMessagesList(
              ),
            ),
            const Divider(),
            _buildMessageInput(),
          ],
        ),
      ),
    );
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
              },
            ),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.video,
                color: AppColors.messengerDarkGrey,
                size: 20,
              ),
              onPressed: () async {
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
                ctrl.sellerMessageController.clear();
              },
            ),
          ],
        ),
      );
    });
  }
}
