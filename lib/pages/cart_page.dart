import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/pages/product_description_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_card.dart';

class CartPage extends StatefulWidget {
  final int index;
  const CartPage({super.key, required this.index});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl){
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchCartDetails();
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/Fish_Market.jpg'), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10,),
                    IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context); // This will navigate back when the back button is pressed
                          },
                        ),
                    const SizedBox(width: 30,),
                    const Text(
                      'Cart',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    // Add any other widgets or empty container as needed
                    const SizedBox(
                      width: 0,
                    )
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemCount: ctrl.cartShowInUi.length,
                      itemBuilder: (context, index) {
                        return CartCard(
                          index: index,
                          name: ctrl.cartShowInUi[index].name ?? 'No name',
                          imageUrl: ctrl.cartShowInUi[index].image ?? 'url',
                          price: ctrl.cartShowInUi[index].price ?? 00,
                          offerTag: '20 % off',
                          onTap: () {
                            Get.to(const ProductDescriptionPage(), arguments: {'data':ctrl.productShowInUi[index]});
                          },);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
