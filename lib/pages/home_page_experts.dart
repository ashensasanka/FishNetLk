import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/drawer_items_for_experts.dart';
import '../features/auth/presentation/screens/create_account_screee.dart';
import '../model/drawer_item_for_experts.dart';
import '../widget/drawer_widget_for_experts.dart';
import 'experts_profile_page.dart';

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