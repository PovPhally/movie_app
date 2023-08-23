import 'package:get/get.dart';
import 'package:movie_app/Screen/movie_app.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateToHome();
    super.onInit();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(
        () => const MovieApp(),
      );
    });
  }
}
