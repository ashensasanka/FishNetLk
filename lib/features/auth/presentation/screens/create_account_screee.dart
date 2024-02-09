import 'dart:io';
import 'package:fishnetlk/core/constants/constants.dart';
import 'package:fishnetlk/core/screens/home_screen.dart';
import 'package:fishnetlk/core/widgets/pick_image_widget.dart';
import 'package:fishnetlk/core/widgets/round_button.dart';
import 'package:fishnetlk/core/widgets/round_text_field.dart';
import 'package:fishnetlk/features/auth/presentation/widgets/birthday_picker.dart';
import 'package:fishnetlk/features/auth/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../controller/home_controller.dart';
import '../../../../widget/drawer_menu_widget.dart';

//Create account for login to the Experts challenge page
class CreateAccountScreen extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;
  const CreateAccountScreen({super.key, required this.openDrawer});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  File? image;
  DateTime? birthday;
  String gender = 'male';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder: (ctrl) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/Fish_Market_4.jpg'), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: Constants.defaultPadding,
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(height: 60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(18),
                          child: DrawerMenuWidget(
                            onClicked: widget.openDrawer,
                          ),
                        ),
                        PickImageWidget(
                          image: image,
                          onImageSelected: (selectedImage) {
                            setState(() {
                              image = selectedImage;
                            });
                          },
                        ),
                        // Add any other widgets or empty container as needed
                        const SizedBox(
                          width: 90,
                        )
                      ],
                    ),
                    const SizedBox(height: 30,),
                    const Text(
                      'Challenge Account',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: RoundTextField(
                            controller: ctrl.fNameController,
                            hintText: 'First name',
                            textInputAction: TextInputAction.next,
                            validator: validateName,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RoundTextField(
                            controller: ctrl.lNameController,
                            hintText: 'Last name',
                            textInputAction: TextInputAction.next,
                            validator: validateName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BirthdayPicker(
                      dateTime: birthday ?? DateTime.now(),
                      onPressed: () async {
                        birthday = await pickSimpleDate(
                          context: context,
                          date: birthday,
                        );
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20), // Move this line here, after the Row and BirthdayPicker
                    RoundButton(
                      onPressed: () {
                        ctrl.addChat(image);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );// Call your function here
                      },
                      label: 'Create Account',
                    ),
                    const SizedBox(height: 290,)
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
