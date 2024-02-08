import 'package:fishnetlk/pages/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';

class CartCard extends StatefulWidget {
  final int index;
  final String name;
  final String imageUrl;
  final double price;
  final String offerTag;
  final Function onTap;

  const CartCard(
      {super.key,
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.offerTag,
        required this.onTap, required this.index});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int number = 3;
 // Initial number
  void increaseNumber() {
    setState(() {
      number++;
    });
  }

  void decreaseNumber() {
    setState(() {
      if (number > 0) {
        number--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return InkWell(
        onTap: (){
          widget.onTap();
        },
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // or MainAxisAlignment.spaceBetween
                  children: [
                    Expanded(
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: 120,
                      ),
                    ),
                    SizedBox(width: 10), // Add a SizedBox with the desired width between the Expanded widgets
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3,),
                            Text(
                              'Rs: ${widget.price}',
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3,),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.offerTag,
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: increaseNumber,
                                  icon: Icon(
                                    Icons.arrow_circle_up,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    number.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: decreaseNumber,
                                  icon: Icon(
                                    Icons.arrow_circle_down_sharp,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      );
    });
  }
}
