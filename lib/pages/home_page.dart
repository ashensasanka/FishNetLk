import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishnetlk/data/drawer_items.dart';
import 'package:fishnetlk/model/drawer_item.dart';
import 'package:fishnetlk/pages/profile_page.dart';
import 'package:fishnetlk/pages/setting_page.dart';
import 'package:fishnetlk/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/create_account_screee.dart';
import 'explorer_page.dart';
import 'favorites_page.dart';
import 'initial_page.dart';

class HomePage extends StatefulWidget{
   const HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late double xOffset ;
  late double yOffset ;
  late double scalerFactor ;
  late bool isDrawerOpen;
  DrawerItem item = DrawerItems.explore;

  @override
  void initState(){
    super.initState();
    closeDrawer();
  }

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

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fish_Market_2.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
            children: [
              buildDrawer(),
              buildPage()
            ]
        ),
      ),
    );
  Widget buildDrawer() => SafeArea(
          child: SizedBox(
            width: xOffset,
            child: DrawerWidget(
              onSelectedItem:(item){
                switch(item){
                  case DrawerItems.logout:signUserOut();
                  default:
                    setState(() => this.item = item);
                    closeDrawer();
                }
              },
            ),
          ));

  Widget buildPage() {

    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen){
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset,yOffset,0)..scale(scalerFactor),

            child: AbsorbPointer(
              absorbing: isDrawerOpen,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 20: 0),
                child: getDrawerPage()
            )
          ),
        ),
      )
    );
  }

  Widget getDrawerPage() {
    switch (item){
      case DrawerItems.favorites:
        return FavoritesPage(openDrawer: openDrawer);
      case DrawerItems.message:
        return CreateAccountScreen(openDrawer: openDrawer);
      case DrawerItems.profile:
        return ProfilePage(openDrawer: openDrawer);
      case DrawerItems.settings:
        return SettingsPage(openDrawer: openDrawer);
      case DrawerItems.home:
        return InitialPage(openDrawer: openDrawer);
      default:
        return ExplorerPage(openDrawer: openDrawer);
    }
  }
}