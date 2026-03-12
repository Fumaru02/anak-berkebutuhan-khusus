import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static Color hex({required String colorCode}) {
    final String containHex = colorCode.toUpperCase().replaceAll('#', '');
    String result = '';
    if (colorCode.length == 7) {
      result = 'FF$containHex';
    }

    return Color(int.parse(result, radix: 16));
  }

  // color list
  // main theme color
  static Color whiteColor = AppColors.hex(colorCode: '#FFFFFF');
  static Color blackColor = AppColors.hex(colorCode: '#424242');
  static Color blueColor = AppColors.hex(colorCode: '#89D4FF');
  static Color greyCard = AppColors.hex(colorCode: '#EAEAEA');
  static Color greyDisabled = AppColors.hex(colorCode: '#DADADA');
  static Color greySecond = AppColors.hex(colorCode: '#EEEEEE');
  static Color grey = AppColors.hex(colorCode: '#B5C0D0');
  static Color greySmooth = AppColors.hex(colorCode: '#D8D9DA');
  static Color orangeActive = AppColors.hex(colorCode: '#D37116');
  //primary
  static Color maroon = AppColors.hex(colorCode: '#3FA2F6');
  static Color blueTransparent = AppColors.hex(colorCode: '#CAF4FF');
  static Color rippleColor =
      // ignore: deprecated_member_use
      AppColors.hex(colorCode: '#EFEFEF').withOpacity(0.20);
}
