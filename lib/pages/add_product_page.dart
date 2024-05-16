import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/widget/drop_down_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File? _image;
  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(
        () {
          _image = File(pickedFile.path);
        },
      );
    }
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
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
                        height: 80,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                              ctrl.fetchOwnProducts(user!.uid);
                            },
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Text(
                            'Add an Item',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: ctrl.productNameCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: const Text('Title'),
                            hintText: 'Enter Title'),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: ctrl.productDescriptionCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: const Text('Product Description'),
                            hintText: 'Enter Your Product Description'),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _getImageFromGallery,
                        child: Container(
                          width: 300,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white, // Set the background color
                            borderRadius:
                                BorderRadius.circular(20), // Round the borders
                          ),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons
                                      .add_photo_alternate, // Add an icon for image selection
                                  size: 100,
                                  color: Colors.grey, // Set the icon color
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: ctrl.productPriceCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: const Text('Unit Price (Rs.)'),
                            hintText: 'Enter Unit Price'),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Flexible(
                            child: DropDownBtn(
                              items: const [
                                'Seafood Items',
                                'Fishing gear',
                                'Boats & machinery'
                              ],
                              selectedItemText: ctrl.category,
                              onSelected: (selectedValue) {
                                ctrl.category = selectedValue ?? 'Category';
                                ctrl.update();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text('Offer Product ?'),
                      const SizedBox(
                        height: 15,
                      ),
                      DropDownBtn(
                        items: const ['true', 'false'],
                        selectedItemText: ctrl.offer.toString(),
                        onSelected: (selectedValue) {
                          ctrl.offer =
                              bool.tryParse(selectedValue ?? 'false') ?? false;
                          ctrl.update();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          ctrl.addProduct(_image, 'image', user!.uid);
                          setState(
                            () {
                              _image = null; // Clear the image
                            },
                          );
                        },
                        child: const Text('Add Product'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
