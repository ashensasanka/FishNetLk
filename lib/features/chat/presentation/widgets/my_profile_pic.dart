import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../controller/home_controller.dart';

class MyProfilePic extends StatelessWidget {
  const MyProfilePic({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          ctrl.makePostUi[1].image as String,
        ),
      );
    });
  }
}
