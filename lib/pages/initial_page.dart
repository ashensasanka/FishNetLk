import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widget/drawer_menu_widget.dart';

class InitialPage extends StatelessWidget {
  final VoidCallback openDrawer;

  InitialPage({Key? key, required this.openDrawer}) : super(key: key);
  Color color = const Color(0xff004BFE);
  @override
  Widget build(BuildContext context) =>
      GetBuilder<HomeController>(builder: (ctrl) {
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: color,
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index){
              print(index);
            },
            items: const [
              Icon(Icons.home,
                color: Colors.white,
              ),
              Icon(Icons.favorite,
                color: Colors.white,
              ),
              Icon(Icons.settings,
                color: Colors.white,
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/Fish_Market.jpg'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center, // Add this line
                  children: [
                    // Move the DrawerMenuWidget here
                    Container(
                      margin: EdgeInsets.all(18),
                      child: DrawerMenuWidget(
                        onClicked: openDrawer,
                      ),
                    ),
                    Text(
                      'Listing Admin',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    // Add any other widgets or empty container as needed
                    Container(),
                    SizedBox(width: 45,)
                  ],
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: ctrl.products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(ctrl.products[index].name ?? ''),
                        subtitle: Text((ctrl.products[index].price ?? 0).toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
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
              Get.to(AddProductPage());
            },
            child: Icon(Icons.add),
          ),
        );
      });
}