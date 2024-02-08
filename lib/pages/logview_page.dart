import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/pages/favorites_page.dart';
import 'package:fishnetlk/pages/home_page.dart';
import 'package:fishnetlk/pages/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logview_info_tile.dart';

class ViewLogPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const ViewLogPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<ViewLogPage> createState() => _WhetherPageState();
}

class _WhetherPageState extends State<ViewLogPage> {
  Color color = const Color(0xff004BFE);
  late double xOffset;
  late double yOffset;
  late double scalerFactor;
  late bool isDrawerOpen;

  void openDrawer() => setState(() {
    xOffset = 230;
    yOffset = 150;
    scalerFactor = 0.6;
    isDrawerOpen = true;
  });
  void closeDrawer() => setState(() {
    xOffset = 0;
    yOffset = 0;
    scalerFactor = 1;
    isDrawerOpen = false;
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFD2DCFF),
          title: Text('Log View',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // This will navigate back when the back button is pressed
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 605,
                child: ListView.separated(
                    itemCount: ctrl.logShowUi.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return LogViewInfoTile(index:index); // Replace with your actual widget
                    },
                  ),
              ),
            )
          ],
        ),
        backgroundColor: Color(0xFFE9EFFF),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: color,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            print(index);
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewLogPage(openDrawer: openDrawer), // Replace with your WeatherPage widget
                ),
              );
            }
            else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesPage(openDrawer: openDrawer), // Replace with your WeatherPage widget
                ),
              );
            }
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.backup_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.bar_chart,
              color: Colors.white,
            ),
          ],
          index: 1, // Set the initial index to 1
        ),
      );
    });
  }
}


