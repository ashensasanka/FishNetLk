import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ChatUserInfo extends StatelessWidget {
  const ChatUserInfo({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder:(ctrl) {
        return Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(ctrl.makePostUi[1].image as String),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ctrl.makePostUi[1].fullName as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
                const Text(
                  'Messenger',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.greyColor,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
