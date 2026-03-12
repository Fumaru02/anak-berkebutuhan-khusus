import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSizer(vertical: 7),
        RubikTextView(
          value: 'Masuk',
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
                title: 'Email',
                hintText: 'enter your email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              CustomTextField(
                title: 'Kata sandi',
                hintText: 'enter your password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.horizontal(4)),
                child: Row(
                  children: [
                    Container(
                      width: SizeConfig.horizontal(5),
                      height: SizeConfig.horizontal(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.blockSizeHorizontal * 1),
                        ),
                        border: Border.all(color: AppColors.blueColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          SizeConfig.safeBlockHorizontal * 0.5,
                        ),
                        child: Container(
                          width: SizeConfig.horizontal(2),
                          height: SizeConfig.horizontal(2),
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                SizeConfig.blockSizeHorizontal * 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SpaceSizer(horizontal: 1),
                    RubikTextView(
                      value: 'Tetap masuk',
                      size: SizeConfig.safeBlockHorizontal * 3,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                    Spacer(),
                    RubikTextView(
                      value: 'Lupa kata sandi?',
                      size: SizeConfig.safeBlockHorizontal * 3,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blueColor,
                    ),
                    SpaceSizer(horizontal: 4),
                  ],
                ),
              ),
              SpaceSizer(vertical: 4),

              CustomFlatButton(text: 'Masuk', onTap: () {}),
              SpaceSizer(vertical: 1.6),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RubikTextView(
                    value: 'Belum memiliki akun',
                    size: SizeConfig.safeBlockHorizontal * 3,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                  SpaceSizer(horizontal: 1),
                  RubikTextView(
                    value: 'Daftar?',
                    size: SizeConfig.safeBlockHorizontal * 3,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor,
                  ),
                  SpaceSizer(horizontal: 4),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
