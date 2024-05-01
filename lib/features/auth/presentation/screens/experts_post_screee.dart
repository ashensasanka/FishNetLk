import 'dart:io';
import 'package:fishnetlk/core/constants/constants.dart';

import 'package:fishnetlk/core/widgets/pick_image_widget.dart';
import 'package:fishnetlk/core/widgets/round_button.dart';
import 'package:fishnetlk/core/widgets/round_text_field.dart';
import 'package:fishnetlk/features/auth/presentation/widgets/birthday_picker.dart';
import 'package:fishnetlk/features/auth/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../controller/home_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/round_icon_button.dart';
import '../../../../widget/drawer_menu_widget.dart';
import '../../../chat/presentation/screens/chats_screen.dart';

//Create account for login to the Experts challenge page
class ExpertsPostScreen extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;
  const ExpertsPostScreen({super.key, required this.openDrawer});

  @override
  ConsumerState<ExpertsPostScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<ExpertsPostScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  File? image;
  DateTime? birthday;
  String gender = 'male';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        builder: (ctrl) {
          return Scaffold(
            backgroundColor: AppColors.greyColor,
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              title: buildFishnetbookText(),
              actions: [
                // built the actions
                _buildSearchWidget(),
                _buildMessengerWidget(),
              ],
              bottom: TabBar(
                tabs: Constants.getHomeScreenTabs(_tabController.index),
                controller: _tabController,
                onTap: (index) {
                  setState(
                    () {},
                  );
                },
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: Constants.screens,
            ),
          );
        },
      );
  Widget buildFishnetbookText() => Row(
        children: [
          DrawerMenuWidget(
            onClicked: widget.openDrawer,
          ),
          Text(
            '   Experts Post',
            style: TextStyle(
              color: AppColors.blueColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget _buildSearchWidget() => const RoundIconButton(
        icon: FontAwesomeIcons.magnifyingGlass,
      );

  Widget _buildMessengerWidget() => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ChatsScreen.routeName);
        },
        child: const RoundIconButton(
          icon: FontAwesomeIcons.facebookMessenger,
        ),
      );
}
