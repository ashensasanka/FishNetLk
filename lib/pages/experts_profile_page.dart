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


  ExpertsProfilePage({Key? key, required this.openDrawer});

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
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: TextStyle(color: Colors.grey)
            ),
            onChanged: (value){
              newValue = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.pop(context),
                child: Text('Cancel',
                  style: TextStyle(color: Colors.white),)),
            TextButton(
                onPressed: ()=> Navigator.of(context).pop(newValue),
                child: Text('Save',
                  style: TextStyle(color: Colors.white),)),
          ],
        ));

    if (newValue.trim().length>0){
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20,),
                            Text(
                              userdata['username'],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            IconButton(onPressed:() => editField('username'), icon: Icon(Icons.edit, size: 20,)),

                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Account Settings',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[900], fontSize: 20),)
                          ],
                        ),
                        MyTextBox(
                          text: userdata['bio'],
                          sectionName: 'bio',
                          onPressed: ()=> editField('bio'),),
                        SizedBox(height: 25,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.person_outline, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Personal information',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 80),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.book_outlined, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Address Book',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 145),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.notifications_none, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Notification',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 170),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Support',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[900], fontSize: 20),)
                          ],
                        ),
                        SizedBox(height: 25,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.question_mark_sharp, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Get Help',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 190),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.local_post_office_outlined, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Give us Feedback',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 110),
                            Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text('Legal',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[900], fontSize: 20),)
                          ],
                        ),
                        SizedBox(height: 25,),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.security_sharp, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Term & conditions',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 110),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TermsPage()), // Replace NextPage with your desired page
                                );
                              },
                              child: Icon(
                                Icons.chevron_right,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const Divider(height:30,indent:30,endIndent:30, thickness:2),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.safety_check, size: 30), // Adjust the size as needed
                            SizedBox(width: 15), // Add some spacing between the icon and the text
                            Text(
                              'Privacy policy',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20, // Adjust the font size as needed
                              ),
                            ),
                            SizedBox(width: 150),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PrivacyPage()), // Replace NextPage with your desired page
                                );
                              },
                              child: Icon(
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
