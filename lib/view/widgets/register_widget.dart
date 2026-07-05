import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/login_view_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/register_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_text_field.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key, required this.animatedController});

  final AnimatedController animatedController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RegisterController(),
      builder: (registerController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 7),
          RubikTextView(
            value: 'Daftar',
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 10,
            color: AppColors.blackColor,
          ),
          BlueStrip(),
          SpaceSizer(vertical: 5),
          Center(
            child: Column(
              children: [
                CustomTextField(
                  title: 'Nama',
                  hintText: 'enter your name',
                  prefixIcon: Icon(Icons.person),
                  controller: registerController.nameController,
                ),
                CustomTextField(
                  title: 'Email',
                  hintText: 'enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                  controller: registerController.emailController,
                ),
                CustomTextField(
                  title: 'Nomer Telphone',
                  hintText: 'enter your phone number',
                  prefixIcon: Icon(Icons.phone_android),
                  controller: registerController.noHPController,
                ),
                CustomTextField(
                  isPasswordField: true,
                  title: 'Kata sandi',
                  hintText: 'enter your password',
                  prefixIcon: Icon(Icons.lock_outline),
                  passwordController: registerController.passwordController,
                ),
                CustomTextField(
                  isPasswordField: true,
                  title: 'Konfirmasi Kata sandi',
                  hintText: 'Confirm your password',
                  prefixIcon: Icon(Icons.lock_outline),
                  passwordController:
                      registerController.confirmPasswordController,
                ),
                SpaceSizer(vertical: 2),

                CustomFlatButton(
                  text: 'Daftar',
                  onTap: () async {
                    await registerController.signUpWithEmailAndPassword();
                    animatedController.toggleAnimate();
                  },
                ),
                SpaceSizer(vertical: 1),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RubikTextView(
                      value: 'Sudah memiliki akun?',
                      size: SizeConfig.safeBlockHorizontal * 3,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                    SpaceSizer(horizontal: 1),
                    RippleButton(
                      onTap: () => animatedController.toggleAnimate(),
                      child: RubikTextView(
                        value: 'Masuk',
                        size: SizeConfig.safeBlockHorizontal * 3,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    SpaceSizer(horizontal: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
