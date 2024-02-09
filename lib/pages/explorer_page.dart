import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/pages/product_description_page.dart';
import 'package:fishnetlk/widget/drop_down_btn.dart';
import 'package:fishnetlk/widget/multi_select_drop_down.dart';
import 'package:fishnetlk/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/drawer_menu_widget.dart';
import 'cart_page.dart';

class ExplorerPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const ExplorerPage({
    Key? key,
    required this.openDrawer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchProducts();
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/Fish_Market_6.jpg'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(18),
                      child: DrawerMenuWidget(
                        onClicked: openDrawer,
                      ),
                    ),
                    Text(
                      'Fish Market',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    // Add any other widgets or empty container as needed
                    IconButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(index: 1,),
                            ),
                          );
                        }, icon: Icon(
                      Icons.shopping_cart,  // Replace with the desired icon
                      size: 24,  // Adjust the size as needed
                      color: Colors.black,  // Adjust the color as needed
                    ),),
                    SizedBox(
                      width: 0,
                    )
                  ],
                ),
                SizedBox(height: 110,),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.productCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            ctrl.filterByCategory(ctrl.productCategories[index].name ?? '');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error'),),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropDownBtn(
                          items: ['Rs:Low to High', 'Rs:High to Low'],
                          selectedItemText: 'Sort by Price',
                          onSelected: (selected) {
                            ctrl.sortByPrice( ascending: selected == 'Rs:Low to High' ? true:false,);
                          }
                      ),
                    ),
                    Flexible(
                        child: MultiSelectDropDown(
                          items: ['Fish1', 'Fish2', 'Fish3'],
                          onSelectionChanged: (selectedItems) {
                            ctrl.filterByBrand(selectedItems);
                          },
                        ))
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemCount: ctrl.productShowInUi.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          index: index,
                          name: ctrl.productShowInUi[index].name ?? 'No name',
                          imageUrl: ctrl.productShowInUi[index].image ?? 'url',
                          price: ctrl.productShowInUi[index].price ?? 00,
                          icon: Icon(
                                Icons.shopping_cart,  // Replace with the desired icon
                                size: 24,  // Adjust the size as needed
                                color: Colors.black,  // Adjust the color as needed
                              ),
                          offerTag: '20 % off',
                          onTap: () {
                            Get.to(ProductDescriptionPage(), arguments: {'data':ctrl.productShowInUi[index]});
                          },);
                      }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}