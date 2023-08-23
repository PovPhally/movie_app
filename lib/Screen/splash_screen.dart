import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: const Image(
          image: AssetImage('assets/images/SplashScreen.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
