import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../controller/home_controller.dart';
import '../screens/chat_screen.dart';
import '/core/constants/extensions.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.userId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.chatroomId,
  }) : super(key: key);

  final String userId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final String chatroomId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ChatScreen.routeName,
              arguments: {
                'userId': userId,
              },
            );
          },
          child: Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://www.shutterstock.com/image-photo/young-handsome-man-beard-wearing-260nw-1768126784.jpg'),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Manoj',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Last Message + Ts
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Flexible(
                            child: Text(
                              lastMessage,
                              style: const TextStyle(
                                color: AppColors.darkGreyColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Text(' → '),
                        Text(
                          lastMessageTs.jm(),
                          style: const TextStyle(
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Message status
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.messengerDarkGrey,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
