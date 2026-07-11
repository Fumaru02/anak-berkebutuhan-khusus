import 'dart:developer';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedController extends GetxController {
  final RxDouble height = RxDouble(40.0);
  final RxDouble width = RxDouble(100.0);
  final RxDouble heightTransformAnimate = RxDouble(60.0);
  final RxBool onTapped = RxBool(false);
  final RxBool onTapIsDaftar = RxBool(false);

  // Gunakan RxBool sebagai ganti ValueNotifier
  final Rx<AnimState> currentState = AnimState.none.obs;

  late PageController pageViewController;
  var currentPageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageViewController = PageController();
  }

  @override
  void onClose() {
    pageViewController.dispose();
    super.onClose();
  }

  void updateCurrentPageIndex(int index) {
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    currentPageIndex.value = index;
  }

  void resetAnimation() {
    height.value = 40.0;
    width.value = 100.0;
    currentState.value = AnimState.none;
    onTapped.value = false;
    onTapIsDaftar.value = false;
    log("Reset Animation ke ukuran awal setelah pindah page");
  }

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
    final newState = currentState.value == AnimState.animate
        ? AnimState.none
        : AnimState.animate;

    currentState.value = newState;

    // Buat RxBool baru dari state saat ini
    final RxBool isAnimatingTrigger = RxBool(newState == AnimState.animate);

    isAnimating(
      heightTransform: newState == AnimState.animate ? 60.0 : 40.0,
      widthTransform: newState == AnimState.animate ? 200.0 : 100.0,
      trigger: isAnimatingTrigger,
    );
    log('State: ${currentState.value}');
  }

  void toggleAnimateDaftar() {
    final newState = currentState.value == AnimState.daftar
        ? AnimState.none
        : AnimState.daftar;

    currentState.value = newState;

    // Buat RxBool baru dari state saat ini
    final RxBool isAnimatingTrigger = RxBool(newState == AnimState.daftar);

    isAnimating(
      heightTransform: newState == AnimState.daftar ? 80.0 : 150.0,
      widthTransform: newState == AnimState.daftar ? 200.0 : 100.0,
      trigger: isAnimatingTrigger,
    );
    log('State: ${currentState.value}');
  }

  void toggleAnimateQuisoner() {
    final newState = currentState.value == AnimState.daftar
        ? AnimState.none
        : AnimState.daftar;

    currentState.value = newState;

    // Buat RxBool baru dari state saat ini
    final RxBool isAnimatingTrigger = RxBool(newState == AnimState.daftar);

    isAnimating(
      heightTransform: newState == AnimState.daftar ? 80.0 : 150.0,
      widthTransform: newState == AnimState.daftar ? 200.0 : 100.0,
      trigger: isAnimatingTrigger,
    );
    log('State: ${currentState.value}');
  }
}
