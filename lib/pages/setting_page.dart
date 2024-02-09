import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fishnetlk/pages/whether.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import '../widget/drawer_menu_widget.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback openDrawer;
  const SettingsPage({
    Key? key,
    required this.openDrawer
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double? heading=0;
  Color color = const Color(0xff004BFE);

  @override
  void initState(){
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  final items = const [
    Icon(Icons.people, size: 30,),
    Icon(Icons.person, size: 30,),
  ];

  int index = 1;
  late double xOffset ;
  late double yOffset ;
  late double scalerFactor ;
  late bool isDrawerOpen;

  void openDrawer() => setState(() {
    xOffset = 230;
    yOffset = 150;
    scalerFactor = 0.6;
    isDrawerOpen = true;
  });

  @override
  void dispose() {
    // Cancel any ongoing async operations here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: color,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index){
          // print(index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WhetherPage(openDrawer: openDrawer), // Replace with your WeatherPage widget
              ),
            );
          }
        },
        items: const [
          Icon(Icons.home,
            color: Colors.white,
          ),
          Icon(Icons.wb_cloudy,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Compass_2.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // Add this line
              children: [
                // Move the DrawerMenuWidget here
                Container(
                  margin: const EdgeInsets.all(18),
                  child: DrawerMenuWidget(
                    onClicked: widget.openDrawer,
                  ),
                ),
                const Text(
                  'Compass',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                // Add any other widgets or empty container as needed
                Container(),
                const SizedBox(width: 45,)
              ],
            ),
            const SizedBox(height: 40,),
            Text("${heading!.ceil()}°",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),),
            const SizedBox(height: 85,),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(angle: ((heading ?? 0) * (pi/180)* -1),
                    child: Image.asset('lib/images/compass.jpg', scale: 1.3,),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
