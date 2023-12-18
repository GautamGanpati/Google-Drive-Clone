import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/screens/loginscreen.dart';
import 'controllers/auth_controller.dart';
import 'screens/navscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Root(),
    );
  }
}

class Root extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      (){
        return authController.user.value == null ? const LoginScreen() : const NavScreen();
      }
    );
  }
}
