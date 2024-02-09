import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import '../services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var options = [
    'Both',
    'Experts',
    'Seller',
    'Buyer',
    'Government Agencies'
  ];
  var _currentItemSelected = "Both";
  var rool = "Both";

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref_rool = FirebaseFirestore.instance.collection('user_rool');
    CollectionReference ref_profile = FirebaseFirestore.instance.collection('Users');
    ref_rool.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    ref_profile.doc(user!.email).set({'username':emailController.text.split('@')[0],
      'bio':'Empty bio..',});

  }
  // sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        ).then((value) => {postDetailsToFirestore(emailController.text, rool)}).catchError((e){})) as UserCredential;

        FirebaseFirestore.instance.collection("Users")
        .doc(userCredential.user!.email)
        .set({
          'username':emailController.text.split('@')[0],
          'bio':'Empty bio..',
        });
      } else {
        // show error message, password don't match
        showErrorMesaage("Password don't match!");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMesaage(e.code);
    }
  }

  // error message to user
  void showErrorMesaage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fish_Market_3.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  const Icon(Icons.supervised_user_circle,size: 100,color: Color(0xFF004CFF),),
                  // welcome back, You've been missed!
                  const Text(
                    'Let\'s create an account for you!',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // username textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // confirm password textfield
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Register as  : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xB3000000),
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.blue,
                        style: TextStyle(),
                        isDense: true,
                        isExpanded: false,
                        iconEnabledColor: Colors.black,
                        focusColor: Colors.white,
                        items: options.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                color: Color(0xB3000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            _currentItemSelected = newValueSelected!;
                            rool = newValueSelected;
                          });
                        },
                        value: _currentItemSelected,
                      ),
                    ],
                  ),
                  // sign in button
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    text: 'Sign Up',
                    onTap: signUserUp,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(
                          onTap: ()=> AuthService().signInWithGoogle(),
                          imagePath: 'lib/images/google.png'),
                      SizedBox(width: 25),
                      // apple button
                      SquareTile(
                          onTap: ()=>{},
                          imagePath: 'lib/images/apple.png')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
