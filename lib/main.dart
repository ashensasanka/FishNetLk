import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/firebase_options.dart';
import 'package:fishnetlk/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes/routes.dart';
import 'features/auth/repository/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  // register out controller


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(HomeController());
  Get.put(AuthRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      // theme: AppTheme.appTheme(),
      debugShowCheckedModeBanner: false,
      home:AuthPage(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}

