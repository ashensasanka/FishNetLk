import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/drawer_menu_widget.dart';

class ListAddPage extends StatelessWidget {
  final VoidCallback openDrawer;

  ListAddPage({Key? key, required this.openDrawer}) : super(key: key);
  Color color = const Color(0xff004BFE);
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'lib/images/Fish_Market.jpg'), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Add this line
                children: [
                  // Move the DrawerMenuWidget here
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: DrawerMenuWidget(
                      onClicked: openDrawer,
                    ),
                  ),
                  const Text(
                    'Add Items',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  // Add any other widgets or empty container as needed
                  Container(),
                  const SizedBox(
                    width: 45,
                  )
                ],
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: ctrl.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ctrl.products[index].name ?? ''),
                      subtitle: Text(
                          (ctrl.products[index].price ?? 0).toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ctrl.deleteProduct(ctrl.products[index].id ?? '');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              const AddProductPage(),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    },
  );
}
