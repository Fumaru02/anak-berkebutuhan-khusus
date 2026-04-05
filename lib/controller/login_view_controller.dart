import 'dart:developer';

import 'package:get/get.dart';

class LoginViewController extends GetxController {
  RxBool onTapTetapMasuk = RxBool(false);
  RxBool onTapIsDaftar = RxBool(false);

  void isOntappedTetapMasuk() {
    onTapTetapMasuk.value = !onTapTetapMasuk.value; // Toggle antara true/false
    log(onTapTetapMasuk.value.toString());
    update();
  }
}
