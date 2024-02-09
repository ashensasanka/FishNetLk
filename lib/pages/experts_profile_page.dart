import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishnetlk/pages/privacy_page.dart';
import 'package:fishnetlk/pages/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/text_box.dart';
import '../core/widgets/pick_image_widget.dart';
import '../widget/drawer_menu_widget.dart';

class ExpertsProfilePage extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;


  const ExpertsProfilePage({super.key, required this.openDrawer});

  @override
  ConsumerState<ExpertsProfilePage> createState() => _ExpertsProfilePageState();
}


class _ExpertsProfilePageState extends ConsumerState<ExpertsProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Edit $field",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: const TextStyle(color: Colors.grey)
            ),
            onChanged: (value){
              newValue = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.pop(context),
                child: const Text('Cancel',
                  style: TextStyle(color: Colors.white),)),
            TextButton(
                onPressed: ()=> Navigator.of(context).pop(newValue),
                child: const Text('Save',
                  style: TextStyle(color: Colors.white),)),
          ],
        ));

    if (newValue.trim().isNotEmpty){
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/Fish_Market_4.jpg'), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(currentUser.email)
                  .snapshots(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  final userdata = snapshot.data!.data() as Map<String, dynamic>;

                  return SingleChildScrollView(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20,),
                            Text(
                              userdata['username'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            IconButton(onPressed:() => editField('username'), icon: const Icon(Icons.edit, size: 20,)),

                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            Text('Account Settings',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[900], fontSize: 20),)
                          ],
                        ),
                        MyTextBox(
                          text: userdata['bio'],
                          sectionName: 'bio',
                          onPressed: ()=> editField('bio'),),
                        const SizedBox(height: 25,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.person_outline, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Personal information',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 80),
                            const Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.book_outlined, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Address Book',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 145),
                            const Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.notifications_none, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Notification',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 170),
                            const Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            Text('Support',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[900], fontSize: 20),)
                          ],
                        ),
                        const SizedBox(height: 25,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.question_mark_sharp, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Get Help',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 190),
                            const Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.local_post_office_outlined, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Give us Feedback',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 110),
                            const Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            Text('Legal',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[900], fontSize: 20),)
                          ],
                        ),
                        const SizedBox(height: 25,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.security_sharp, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Term & conditions',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 110),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TermsPage()), // Replace NextPage with your desired page
                                );
                              },
                              child: const Icon(
                                Icons.chevron_right,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Icon(Icons.safety_check, size: 30), // Adjust the size as needed
                            const SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Privacy policy',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(width: 150),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PrivacyPage()), // Replace NextPage with your desired page
                                );
                              },
                              child: const Icon(
                                Icons.chevron_right,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  );
                } else if (snapshot.hasError){
                  return Center(
                    child: Text('Error${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
        )
    );
  }
}
