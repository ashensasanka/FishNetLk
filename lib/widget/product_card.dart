import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../controller/home_controller.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final String name;
  final String imageUrl;
  final double price;
  final String offerTag;
  final Function onTap;
  final Icon icon;
  const ProductCard(
      {super.key,
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.offerTag,
        required this.onTap, required this.icon, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return InkWell(
        onTap: (){
          onTap();
        },
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 120,
                ),
                SizedBox(height: 9),
                Text(
                  name,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 9),
                Text(
                  'Rs: $price',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4,),
                // IconButton(onPressed: (){
                // }, icon: icon),
                Container(

                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            offerTag,
                            style: const TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 77,),
                      InkWell(
                        onTap: () {
                          ctrl.addCart(index);
                        },
                        child: Flexible(
                          child: Icon(
                            Icons.shopping_cart,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
