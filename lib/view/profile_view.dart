import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/frame/frame_scaffold.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_text_field.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/register_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/login_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/welcome_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/white_wave_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: FrameScaffold(
        heightBar: 0,
        elevation: 0,
        color: Colors.black,
        statusBarColor: Colors.black,
        colorScaffold: Colors.black,
        statusBarBrightness: Brightness.light,
        view: Stack(
          children: [
            SizedBox(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(100),
              child: Image.asset(AssetList.splashScreen, fit: BoxFit.cover),
            ),
            Container(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(100),
              color: AppColors.blueColor.withValues(alpha: 0.9),
            ),
            Column(
              children: [
                Container(
                  color: AppColors.whiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceSizer(vertical: 5),

                      Center(
                        child: Container(
                          width: SizeConfig.horizontal(40),
                          height: SizeConfig.horizontal(40),
                          decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SpaceSizer(vertical: 3),
                      RubikTextView(
                        value: 'Profile',
                        fontWeight: FontWeight.w500,
                        size: SizeConfig.safeBlockHorizontal * 10,
                        color: AppColors.blackColor,
                      ),
                      BlueStrip(),
                      SpaceSizer(vertical: 2),
                      Center(
                        child: Column(
                          children: [
                            CustomTextField(
                              title: 'Email',
                              hintText: 'enter your email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            CustomTextField(
                              title: 'Nomor Telphone',
                              hintText: 'enter your phone number',
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                            RubikTextView(
                              value: 'Ganti Kata Sandi?',
                              fontWeight: FontWeight.w500,
                              size: SizeConfig.safeBlockHorizontal * 5,
                              color: AppColors.blackColor,
                            ),
                            CustomTextField(
                              title: 'Kata sandi',
                              hintText: 'enter your password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            CustomTextField(
                              title: 'Konfirmasi Kata sandi',
                              hintText: 'Confirm your password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            SpaceSizer(vertical: 1),

                            CustomFlatButton(
                              text: 'Ganti Kata sandi',
                              onTap: () {},
                            ),
                            SpaceSizer(vertical: 1),

                            RubikTextView(
                              value: 'Keluar?',
                              size: SizeConfig.safeBlockHorizontal * 4,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                            SpaceSizer(vertical: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
