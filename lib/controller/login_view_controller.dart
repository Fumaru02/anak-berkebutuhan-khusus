import 'dart:developer';

import 'package:anak_berkebutuhan_khusus/helper/snackbar.dart';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:anak_berkebutuhan_khusus/view/frame/frame_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewController extends GetxController {
  RxBool onTapTetapMasuk = RxBool(false);
  RxBool onTapIsDaftar = RxBool(false);
  final RxBool isTapped = false.obs;
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void isOntappedTetapMasuk() {
    onTapTetapMasuk.value = !onTapTetapMasuk.value; // Toggle antara true/false
    log(onTapTetapMasuk.value.toString());
    update();
  }

  dynamic signInWithEmailAndPassword() async {
    try {
      isTapped.value = true;
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!credential.user!.emailVerified) {
        Snack.show(
          SnackbarType.error,
          'Email Verification',
          'Email kamu belum terverifikasi mohon check inbox/spam',
        );
        isTapped.value = false;
        return;
      }
      if (credential.user == null) {
        Snack.show(
          SnackbarType.error,
          'Email Verification',
          'Email kamu belum terverifikasi mohon check inbox/spam',
        );
        isTapped.value = false;
        return;
      }
      Get.offAll(const FrameView());
      isTapped.value = false;

      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Snack.show(
            SnackbarType.error,
            'invalid email',
            'Email tidak dapat ditemukan coba lagi',
          );
          isTapped.value = false;
          break;
        case 'invalid-credential':
          Snack.show(
            SnackbarType.error,
            'wrong email/password',
            'Email/Password salah coba lagi',
          );
          isTapped.value = false;
          break;
        case 'user-not-found':
          Snack.show(
            SnackbarType.error,
            'Unknown email',
            'Akun tidak dapat ditemukan coba lagi/password salah',
          );
          isTapped.value = false;
          break;
        case 'ERROR_USER_DISABLED':
          Snack.show(
            SnackbarType.error,
            'Error User',
            'Akunmu dihentikan untuk sementara waktu',
          );
          isTapped.value = false;
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          Snack.show(
            SnackbarType.error,
            'Error',
            'Too many request try again later',
          );
          isTapped.value = false;
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          Snack.show(SnackbarType.error, 'Unknown user', 'Operasi dihentikan');
          isTapped.value = false;
          break;
        default:
          Snack.show(
            SnackbarType.error,
            'Error',
            'Something error please try again later',
          );
          isTapped.value = false;
          return null;
      }
    }
  }
}
