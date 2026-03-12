import 'dart:developer';

import 'package:get/get.dart';

class AnimatedController extends GetxController {
  final RxDouble height = RxDouble(40);
  final RxDouble width = RxDouble(100);
  final RxBool onTapped = RxBool(false);

  void isAnimating(double heightTransform, double widthTransform) {
    if (onTapped.value) {
      height.value = heightTransform;
      width.value = widthTransform;
      log("Animasi dimulai - test1");
    } else {
      // Reset ke ukuran awal jika perlu
      height.value = 40.0;
      width.value = 100.0;
      log("Reset ke ukuran awal");
    }
    log("test2");
  }

  void toggleAnimate() {
    onTapped.toggle();
    if (onTapped.value) {
      isAnimating(60.0, 200.0); // Contoh nilai animasi
    } else {
      isAnimating(40.0, 100.0); // Kembali ke ukuran awal
    }
  }
}
