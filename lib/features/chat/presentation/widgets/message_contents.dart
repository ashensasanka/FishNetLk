import 'package:flutter/material.dart';
import '/core/constants/app_colors.dart';

class MessageContents extends StatelessWidget {
  const MessageContents({
    super.key,
    required this.message,
    this.isSentMessage = false,
  });

  final String message;
  final bool isSentMessage;

  @override
  Widget build(BuildContext context) {
      return Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isSentMessage ? AppColors.whiteColor : AppColors.blackColor,
        ),
      );
  }
}
