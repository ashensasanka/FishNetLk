import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishnetlk/pages/home_page.dart';
import 'package:fishnetlk/pages/home_page_experts.dart';
import 'package:fishnetlk/pages/login_or_registerpage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null) {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('user_rool').doc(user.uid).get(),
                builder: (context, documentSnapshot) {
                  if (documentSnapshot.hasData && documentSnapshot.data != null) {
                    String userRole = documentSnapshot.data!.get('rool');
                    return userRole == 'Experts' ? HomePageExperts() : HomePage();
                  } else {
                    return CircularProgressIndicator(); // Handle loading state
                  }
                },
              );
            }
          }

          // User is not logged in
          return LoginOrRegisterPage();
        },
      ),
    );
  }
}
