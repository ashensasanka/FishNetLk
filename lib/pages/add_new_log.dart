import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';
import '../features/auth/utils/utils.dart';
import '../widget/logday_picker.dart';

class AddNewLogPage extends StatefulWidget {
  const AddNewLogPage({super.key});

  @override
  State<AddNewLogPage> createState() => _AddNewLogPageState();
}

class _AddNewLogPageState extends State<AddNewLogPage> {
  String locationMessage = 'Current location of the user';
  late String ctrllat;
  late String ctrllong;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder: (ctrl) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'lib/images/Fish_Market.jpg'), // Replace with your image asset path
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
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.center, // Add this line
                    children: [
                      // Add any other widgets or empty container as needed
                      Container(),
                      const SizedBox(
                        width: 45,
                      )
                    ],
                  ),
                  TextField(
                    controller: ctrl.fishNameCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: const Text('Fish Name'),
                        hintText: 'Enter Fish Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      controller: ctrl.fishQuantityCtrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: const Text('Quantity'),
                          hintText: 'Enter Fish Quantity')),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ctrl.fishingMethodCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text('Method of Fishing'),
                        hintText: 'Enter Fishing Method'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(locationMessage),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        _getCurrentLocation().then(
                              (value) {
                            ctrl.lat = '${value.latitude}';
                            ctrl.long = '${value.longitude}';
                            ctrllat = ctrl.lat as String;
                            ctrllong = ctrl.long as String;
                            setState(
                                  () {
                                locationMessage =
                                'Latitude: $ctrllat, Longitude: $ctrllong';
                              },
                            );
                          },
                        );
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
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      ctrl.addLogDetails(user!.uid);
                      ctrl.fishNameCtrl.clear();
                      ctrl.fishingMethodCtrl.clear();
                      ctrl.fishLocationCtrl.clear();
                      ctrl.fishQuantityCtrl.clear();
                      ctrl.fetchLogDetails(user!.uid);
                    },
                    child: const Text('Update Log'),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, We can not proceed');
    }
    return await Geolocator.getCurrentPosition();
  }
}
