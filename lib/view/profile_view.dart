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
                Spacer(),
                WhiteWaveContainer(
                  height: SizeConfig.horizontal(180),
                  width: SizeConfig.horizontal(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceSizer(vertical: 7),
                      RubikTextView(
                        value: 'Profile',
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
                              title: 'Nomer Telphone',
                              hintText: 'enter your email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            CustomTextField(
                              title: 'Nomer Telephone',
                              hintText: 'enter your phone number',
                              prefixIcon: Icon(Icons.phone_android),
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
                            SpaceSizer(vertical: 2),

                            CustomFlatButton(text: 'Masuk', onTap: () {}),
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

                                SpaceSizer(horizontal: 4),
                              ],
                            ),
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
