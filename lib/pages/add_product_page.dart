import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/widget/drop_down_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
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
                  const SizedBox(height: 80,),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context); // Navigate back when the back button is pressed
                        },
                      ),
                      const SizedBox(width: 25,),
                      const Text(
                        'Add a New Listing',
                        style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: ctrl.productNameCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Title'),
                        hintText: 'Enter Title'
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: ctrl.productDescriptionCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Product Description'),
                        hintText: 'Enter Your Product Description'
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: ctrl.productImgCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Image URL'),
                        hintText: 'Enter Your Image URL'
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                      controller: ctrl.productPriceCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        label: const Text('Unit Price (Rs.)'),
                        hintText: 'Enter Unit Price'
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                          child: DropDownBtn(
                            items: const ['Fish', 'Accessories', 'Boats','Market'],
                            selectedItemText: ctrl.category,
                            onSelected: (selectedValue) {
                              ctrl.category = selectedValue ?? 'Category';
                              ctrl.update();
                            },
                          )),
                      Flexible(
                          child: DropDownBtn(
                            items: const ['Brand1', 'Brand2', 'Brand3',],
                            selectedItemText: ctrl.brand,
                            onSelected: (selectedValue) {
                              ctrl.brand = selectedValue ?? 'Fish Category';
                              ctrl.update();
                            },
                          )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text('Offer Product ?'),
                  const SizedBox(height: 15,),
                  DropDownBtn(
                    items: const ['true', 'false'],
                    selectedItemText: ctrl.offer.toString(),
                    onSelected: (selectedValue) {
                      ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();
                    },),
                  const SizedBox(height: 15,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        ctrl.addProduct();
                      }, child: const Text('Add Product'))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
