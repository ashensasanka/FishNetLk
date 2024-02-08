import 'package:fishnetlk/model/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fishnetlk/model/drawer_item.dart';

import '../model/drawer_item_for_experts.dart';

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