import 'package:fishnetlk/core/screens/error_screen.dart';
import 'package:fishnetlk/core/screens/loader.dart';
import 'package:fishnetlk/features/auth/providers/get_user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/home_controller.dart';

class MyProfilePic extends StatelessWidget {
  const MyProfilePic({super.key});
  @override
  Widget build(BuildContext context) {
    // final userInfo = ref.watch(getUserInfoProvider);

    return GetBuilder<HomeController>(builder: (ctrl) {
        return CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            ctrl.makePostUi[1].image as String,
          ),
        );
      });
    //   error: (error, stackTrace) {
    //     return ErrorScreen(error: error.toString());
    //   },
    //   loading: () {
    //     return const Loader();
    //   },
    // );
  }
}
