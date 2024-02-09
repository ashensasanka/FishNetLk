import 'package:fishnetlk/model/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Drawer items
class DrawerItems {
  static const explore = DrawerItem(title: 'Market', icon: Icons.explore, iconSize: 10);
  static const home = DrawerItem(title: 'Listing Admin', icon: FontAwesomeIcons.house, iconSize: 10);
  static const favorites = DrawerItem(title: 'Logs', icon: Icons.leaderboard, iconSize: 10);
  static const message = DrawerItem(title: 'Challenges', icon: FontAwesomeIcons.personRunning, iconSize: 80);
  static const profile = DrawerItem(title: 'Profile', icon: FontAwesomeIcons.userLarge,iconSize: 10);
  static const settings = DrawerItem(title: 'Compass', icon: Icons.compass_calibration_sharp,iconSize: 10);
  static const logout = DrawerItem(title: 'Logout', icon: Icons.logout,iconSize: 10);

  static final List<DrawerItem> all = [
    explore,
    home,
    favorites,
    message,
    profile,
    settings,
    logout
  ];
}