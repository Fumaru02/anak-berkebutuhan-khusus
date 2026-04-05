import 'dart:developer';

import 'package:get/get.dart';

class AnimatedController extends GetxController {
  final RxDouble height = RxDouble(40.0);
  final RxDouble width = RxDouble(100.0);
  final RxBool onTapped = RxBool(false);
  final RxBool onTapIsDaftar = RxBool(false);

  void isAnimating({
    required double heightTransform,
    required double widthTransform,
    required RxBool trigger,
  }) {
    if (trigger.value) {
      height.value = heightTransform;
      width.value = widthTransform;
      log("Animasi dimulai - test1");
    } else {
      // Reset ke ukuran awal
      height.value = 40.0;
      width.value = 100.0;
      log("Reset ke ukuran awal");
    }
    log("test2");
  }

  void toggleAnimate() {
    onTapped.toggle();
    isAnimating(
      heightTransform: onTapped.value ? 60.0 : 40.0,
      widthTransform: onTapped.value ? 200.0 : 100.0,
      trigger: onTapped,
    );
  }

  void toggleAnimateDaftar() {
    onTapIsDaftar.toggle();
    isAnimating(
      heightTransform: onTapIsDaftar.value ? 80.0 : 60.0,
      widthTransform: onTapIsDaftar.value ? 200.0 : 100.0,
      trigger: onTapIsDaftar,
    );
  }
}
