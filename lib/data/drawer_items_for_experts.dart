import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/drawer_item_for_experts.dart';

//Drawer items for experts
class ExpertsDrawerItems {
  static const message = ExpertsDrawerItem(title: 'Challenges', icon: FontAwesomeIcons.running);
  static const profile = ExpertsDrawerItem(title: 'Profile', icon: FontAwesomeIcons.userAlt);
  static const logout = ExpertsDrawerItem(title: 'Logout', icon: Icons.logout);

  static final List<ExpertsDrawerItem> all = [
    message,
    profile,
    logout
  ];
}