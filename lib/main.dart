import 'package:fishnetlk/config/themes/app_theme.dart';
import 'package:fishnetlk/controller/home_controller.dart';
import 'package:fishnetlk/firebase_options.dart';
import 'package:fishnetlk/pages/auth_page.dart';
import 'package:fishnetlk/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'config/routes/routes.dart';
import 'features/auth/repository/auth_repository.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';
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
    return GetMaterialApp(
      // theme: AppTheme.appTheme(),
      debugShowCheckedModeBanner: false,
      home:AuthPage(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}

