import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';
import 'logview_info_tile.dart';
import 'order_view_info_tile.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD2DCFF),
          title: const Text('My Orders',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // This will navigate back when the back button is pressed
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 605,
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return OrdersViewInfoTile(index:index); // Replace with your actual widget
                  },
                ),
              ),
            )
          ],
        ),
        backgroundColor: const Color(0xFFE9EFFF),
      );
    });
  }
}
