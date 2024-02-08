import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishnetlk/data/drawer_items.dart';
import 'package:fishnetlk/model/drawer_item.dart';
import 'package:fishnetlk/pages/profile_page.dart';
import 'package:fishnetlk/pages/setting_page.dart';
import 'package:fishnetlk/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../data/drawer_items_for_experts.dart';
import '../features/auth/presentation/screens/create_account_screee.dart';
import '../model/drawer_item_for_experts.dart';
import '../widget/drawer_widget_for_experts.dart';
import 'experts_profile_page.dart';
import 'explorer_page.dart';
import 'favorites_page.dart';
import 'initial_page.dart';
import 'message_page.dart';

class HomePageExperts extends StatefulWidget{
  const HomePageExperts({Key? key}) : super(key:key);

  @override
  State<HomePageExperts> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageExperts> {


  late double xOffset ;
  late double yOffset ;
  late double scalerFactor ;
  late bool isDrawerOpen;
  ExpertsDrawerItem item = ExpertsDrawerItems.message;


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
        backgroundColor: Colors.deepPurple,
        // bottomNavigationBar: CurvedNavigationBar(
        //   backgroundColor: Colors.deepPurple.shade200,
        //   color: Colors.deepPurple,
        //   animationDuration: const Duration(milliseconds: 300),
        //   onTap: (index){
        //     print(index);
        //   },
        //   items: const [
        //     Icon(Icons.home,
        //       color: Colors.white,
        //     ),
        //     Icon(Icons.favorite,
        //       color: Colors.white,
        //     ),
        //     Icon(Icons.settings,
        //       color: Colors.white,
        //     ),
        //   ],
        // ),
        // appBar: AppBar(
        //   actions: [
        //     IconButton(onPressed: signUserOut,
        //       icon: const Icon(Icons.logout),
        //     )
        //   ],
        // ),
        body: Container(
          decoration: BoxDecoration(
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
        child: ExpertsDrawerWidget(
          onSelectedItem:(item){
            switch(item){
              case ExpertsDrawerItems.logout:signUserOut();
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
                  child: Container(
                    child: getDrawerPage(),

                  ),
                )
            ),
          ),
        )
    );
  }



  Widget getDrawerPage() {
    switch (item){
      case ExpertsDrawerItems.profile:
        return ExpertsProfilePage(openDrawer: openDrawer);
      default:
        return CreateAccountScreen(openDrawer: openDrawer);
    }
  }
}