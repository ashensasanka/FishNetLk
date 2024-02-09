import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fishnetlk/pages/logview_page.dart';
import 'package:fishnetlk/pages/view_graph_page.dart';
import 'package:fishnetlk/widget/logday_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../features/auth/utils/utils.dart';
import '../widget/drawer_menu_widget.dart';
import 'package:fishnetlk/controller/home_controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FavoritesPage extends StatefulWidget{
  final VoidCallback openDrawer;

  const FavoritesPage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  DateTime? logday;
  late String lat;
  late String long;
  late String ctrllat;
  late String ctrllong;
  Color color = const Color(0xff004BFE);
  String locationMessage = 'Current location of the user';
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
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder: (ctrl) {
      return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: color,
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index){
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewLogPage(openDrawer: openDrawer), // Replace with your WeatherPage widget
                  ),
                );
              }
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewGraphPage(), // Replace with your WeatherPage widget
                  ),
                );
              }
            },

            items: const [
              Icon(Icons.home,
                color: Colors.white,
              ),
              Icon(Icons.backup_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.bar_chart,
                color: Colors.white,
              ),
            ],
          ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fish_Market.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
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
                      'Add a New Log',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    // Add any other widgets or empty container as needed
                    Container(),
                    const SizedBox(width: 45,)
                  ],
                ),
              TextField(
                  controller: ctrl.fishNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      label: const Text('Fish Name'),
                      hintText: 'Enter Fish Name'
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ctrl.fishQuantityCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      label: const Text('Quantity'),
                      hintText: 'Enter Fish Quantity'
                  )
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrl.fishingMethodCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Method of Fishing'),
                        hintText: 'Enter Fishing Method'
                    )
                ),
                const SizedBox(height: 10,),
                TextField(
                    controller: ctrl.fishCostCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Costs'),
                        hintText: 'Enter Fish Cost'
                    )
                ),
                const SizedBox(height: 10,),
                TextField(
                    controller: ctrl.sellPriceCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Selling Price 1kg'),
                        hintText: 'Enter Selling Price'
                    )
                ),
                const SizedBox(height: 10,),
                TextField(
                    controller: ctrl.soldQuantityCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Sold Quantity (kg)'),
                        hintText: 'Enter Sold Quantity'
                    )
                ),
                const SizedBox(height: 10,),
                Text(locationMessage),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: (){
                  _getCurrentLocation().then((value) {
                    ctrl.lat = '${value.latitude}';
                    ctrl.long = '${value.longitude}';
                    ctrllat = ctrl.lat as String;
                    ctrllong = ctrl.long as String;
                    setState(() {
                      locationMessage = 'Latitude: $ctrllat, Longitude: $ctrllong';
                    });
                  });
                },
                    child: const Text('Get Location')),
                const SizedBox(height: 10),
                LogdayPicker(
                    dateTime: ctrl.logday ?? DateTime.now(),
                    onPressed: () async {
                      DateTime? selectedDate = await pickSimpleDate(
                        context: context,
                        date: ctrl.logday,
                      );

                      if (selectedDate != null) {
                        ctrl.handleDateSelection(selectedDate);
                      }
                    }
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      ctrl.addLogDetails();
                      ctrl.fishNameCtrl.clear();
                      ctrl.fishingMethodCtrl.clear();
                      ctrl.fishLocationCtrl.clear();
                      ctrl.fishQuantityCtrl.clear();
                      ctrl.fishCostCtrl.clear();
                      ctrl.sellPriceCtrl.clear();
                      ctrl.soldQuantityCtrl.clear();
                      ctrl.fetchLogDetails();
                    }, child: const Text('Update Log'))
              ]
            )
          )
        ),
      )
      );
    },

  );
  Future<Position>_getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled){
      return Future.error('Location service are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied, We can not proceed');
    }
    return await Geolocator.getCurrentPosition();
  }
}