import 'dart:io';

import 'package:fishnetlk/core/constants/app_colors.dart';
import 'package:fishnetlk/core/constants/constants.dart';
import 'package:fishnetlk/core/screens/home_screen.dart';
import 'package:fishnetlk/core/utils/utils.dart';
import 'package:fishnetlk/core/widgets/pick_image_widget.dart';
import 'package:fishnetlk/core/widgets/round_button.dart';
import 'package:fishnetlk/core/widgets/round_text_field.dart';
import 'package:fishnetlk/features/auth/presentation/widgets/birthday_picker.dart';
import 'package:fishnetlk/features/auth/presentation/widgets/gender_picker.dart';
import 'package:fishnetlk/features/auth/providers/auth_provider.dart';
import 'package:fishnetlk/features/auth/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/home_controller.dart';
import '../../../../widget/drawer_menu_widget.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;
  const CreateAccountScreen({Key? key, required this.openDrawer});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  // File? image;
  // DateTime? birthday;
  // String gender = 'male';
  // bool isLoading = false;
  //
  // // controllers
  // late final TextEditingController _fNameController;
  // late final TextEditingController _lNameController;
  //
  //
  // @override
  // void initState() {
  //   _fNameController = TextEditingController();
  //   _lNameController = TextEditingController();
  //
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _fNameController.dispose();
  //   _lNameController.dispose();
  //
  //   super.dispose();
  // }
  //
  // Future<void> createAccount() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     // setState(() => isLoading = true);
  //     await ref
  //         .read(authProvider)
  //         .createAccount(
  //           fullName: '${_fNameController.text} ${_lNameController.text}',
  //           birthday: birthday ?? DateTime.now(),
  //           gender: gender,
  //           image: image,
  //         )
  //         .then((credential) {
  //       if (!credential!.user!.emailVerified) {
  //         Navigator.pop(context);
  //       }
  //     }).catchError((_) {
  //       setState(() => isLoading = false);
  //     });
  //     setState(() => isLoading = false);
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context)=> GetBuilder<HomeController>(
  // builder: (ctrl)  {
  //   return Scaffold(
  //     backgroundColor: AppColors.realWhiteColor,
  //     appBar: AppBar(
  //       backgroundColor: Colors.orange,
  //       leading: DrawerMenuWidget(onClicked: widget.openDrawer),
  //       title: Text('Message Page'),),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: Constants.defaultPadding,
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             children: [
  //               GestureDetector(
  //                 onTap: () async {
  //                   image = await pickImage();
  //                   setState(() {});
  //                 },
  //                 child: PickImageWidget(image: image),
  //               ),
  //               const SizedBox(height: 20),
  //               Row(
  //                 children: [
  //                   // First Name Text Field
  //                   Expanded(
  //                     child: RoundTextField(
  //                       controller: ctrl.fNameController,
  //                       hintText: 'First name',
  //                       textInputAction: TextInputAction.next,
  //                       validator: validateName,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   // Last Name Text Field
  //                   Expanded(
  //                     child: RoundTextField(
  //                       controller: ctrl.lNameController,
  //                       hintText: 'Last name',
  //                       textInputAction: TextInputAction.next,
  //                       validator: validateName,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
  //               BirthdayPicker(
  //                 dateTime: birthday ?? DateTime.now(),
  //                 onPressed: () async {
  //                   birthday = await pickSimpleDate(
  //                     context: context,
  //                     date: birthday,
  //                   );
  //                   setState(() {});
  //                 },
  //               ),
  //               const SizedBox(height: 20),
  //               GenderPicker(
  //                 gender: gender,
  //                 onChanged: (value) {
  //                   gender = value ?? 'male';
  //                   setState(() {});
  //                 },
  //               ),
  //               // Phone number / email text field
  //
  //               const SizedBox(height: 20),
  //               isLoading
  //                   ? const Center(child: CircularProgressIndicator())
  //                   : RoundButton(
  //                       onPressed: ctrl.addChat(),
  //                       label: 'Create Account',
  //                     ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // });

  File? image;
  DateTime? birthday;
  String gender = 'male';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder: (ctrl) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                    SizedBox(height: 60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(18),
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
                        SizedBox(
                          width: 90,
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text(
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
                    // isLoading
                    //     ? const Center(child: CircularProgressIndicator())
                    //     :
                    RoundButton(
                      onPressed: () {
                        ctrl.addChat(image);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                        );// Call your function here
                      },
                      label: 'Create Account',
                    ),
                    SizedBox(height: 290,)
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
