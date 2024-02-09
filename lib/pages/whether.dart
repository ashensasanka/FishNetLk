import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhetherPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const WhetherPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<WhetherPage> createState() => _WhetherPageState();
}

class _WhetherPageState extends State<WhetherPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD2DCFF),
        title: Text('Whether',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 700,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/Whether_1.jpg'), // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 700, // Set the desired height for your image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/Whether_3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
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
                    WhetherPage(openDrawer: openDrawer), // Replace with your WeatherPage widget
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
            Icons.wb_cloudy,
            color: Colors.white,
          ),
        ],
        index: 1, // Set the initial index to 1
      ),
    );
  }
}


