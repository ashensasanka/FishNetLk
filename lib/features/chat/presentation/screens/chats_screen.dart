import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:fishnetlk/core/constants/constants.dart';
import 'package:fishnetlk/core/widgets/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/chat_tile.dart';
import '../widgets/my_profile_pic.dart';

class ChatsScreen extends StatefulWidget {
  static const routeName = '/chats-screen';

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: Constants.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
    //             // build chats app bar
                _buildChatsAppBar(),
                const SizedBox(height: 20),
    //             // Search widget
                _buildChatsSearchWidget(),
                const SizedBox(height: 30),
    //             // Chats List
                SizedBox(
                  height: 70,
                  child: ChatTile(
                    userId: 'userId',
                    lastMessage: 'chat.lastMessage',
                    lastMessageTs: DateTime(2017, 9, 7, 17, 30),
                    chatroomId: 'chat.chatroomId',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
     );
  }

  Widget _buildChatsAppBar() => Row(
        children: [
          const MyProfilePic(),
          const SizedBox(width: 5),
          const Text(
            'Chats',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          RoundIconButton(
            icon: FontAwesomeIcons.camera,
            onPressed: () {},
          )
        ],
      );
  //
  Widget _buildChatsSearchWidget() => Container(
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.search),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(),
                ),
              ),
            ),
          ],
        ),
      );
}
