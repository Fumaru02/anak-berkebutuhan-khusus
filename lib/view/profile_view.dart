import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/frame_controller.dart';
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
    final FrameController frameController = Get.find<FrameController>();

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
            // Background Image
            SizedBox(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(100),
              child: Image.asset(AssetList.splashScreen, fit: BoxFit.cover),
            ),
            // Overlay
            Container(
              width: SizeConfig.horizontal(100),
              height: SizeConfig.vertical(100),
              color: AppColors.blueColor.withAlpha(230),
            ),
            // Main Content
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 3,
                      bottom: SizeConfig.safeBlockVertical * 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Header
                        Center(
                          child: Column(
                            children: [
                              // Profile Picture
                              Container(
                                width: SizeConfig.horizontal(30),
                                height: SizeConfig.horizontal(30),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.blueColor,
                                      AppColors.blueColor.withOpacity(0.7),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blueColor.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Obx(
                                    () => RubikTextView(
                                      value:
                                          frameController
                                              .userEmail
                                              .value
                                              .isNotEmpty
                                          ? frameController.userName.value[0]
                                                .toUpperCase()
                                          : '?',
                                      fontWeight: FontWeight.bold,
                                      size: SizeConfig.safeBlockHorizontal * 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SpaceSizer(vertical: 2),
                              // Username / Email
                              Obx(
                                () => RubikTextView(
                                  value:
                                      frameController.userEmail.value.isNotEmpty
                                      ? frameController.userEmail.value
                                      : 'Guest User',
                                  fontWeight: FontWeight.w600,
                                  size: SizeConfig.safeBlockHorizontal * 5,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              SpaceSizer(vertical: 0.5),
                              RubikTextView(
                                value: 'Profile Anda',
                                fontWeight: FontWeight.w400,
                                size: SizeConfig.safeBlockHorizontal * 3.5,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        ),

                        SpaceSizer(vertical: 3),
                        BlueStrip(),
                        SpaceSizer(vertical: 3),

                        // Section Title
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 5,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: AppColors.blueColor,
                                size: SizeConfig.safeBlockHorizontal * 5,
                              ),
                              SpaceSizer(horizontal: 2),
                              RubikTextView(
                                value: 'Informasi Akun',
                                fontWeight: FontWeight.w600,
                                size: SizeConfig.safeBlockHorizontal * 4.5,
                                color: AppColors.blackColor,
                              ),
                            ],
                          ),
                        ),
                        SpaceSizer(vertical: 1.5),

                        // Email Card
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 4,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 3.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey.shade50, Colors.white],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email Section
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                        SizeConfig.safeBlockHorizontal * 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.blueColor.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: AppColors.blueColor,
                                        size:
                                            SizeConfig.safeBlockHorizontal *
                                            4.5,
                                      ),
                                    ),
                                    SpaceSizer(horizontal: 3),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RubikTextView(
                                            value: 'Alamat Email',
                                            fontWeight: FontWeight.w400,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                2.8,
                                            color: Colors.grey.shade500,
                                          ),
                                          SpaceSizer(vertical: 0.3),
                                          Obx(
                                            () => RubikTextView(
                                              value:
                                                  frameController
                                                      .userEmail
                                                      .value
                                                      .isNotEmpty
                                                  ? frameController
                                                        .userEmail
                                                        .value
                                                  : 'Email belum terdaftar',
                                              fontWeight: FontWeight.w500,
                                              size:
                                                  SizeConfig
                                                      .safeBlockHorizontal *
                                                  3.8,
                                              color:
                                                  frameController
                                                      .userEmail
                                                      .value
                                                      .isNotEmpty
                                                  ? AppColors.blackColor
                                                  : Colors.grey.shade400,
                                              maxLines: 1,
                                              overFlow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (frameController
                                        .userEmail
                                        .value
                                        .isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          // Copy email functionality
                                          // Clipboard.setData(ClipboardData(text: frameController.userEmail.value));
                                          // Get.snackbar('Berhasil', 'Email telah disalin');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.copy,
                                            color: Colors.grey.shade600,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                3.5,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                // Email Status
                                if (frameController.userEmail.value.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: SizeConfig.safeBlockVertical * 1.5,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Colors.green.shade600,
                                          size:
                                              SizeConfig.safeBlockHorizontal *
                                              3.5,
                                        ),
                                        SpaceSizer(horizontal: 1),
                                        RubikTextView(
                                          value: 'Email terverifikasi',
                                          fontWeight: FontWeight.w400,
                                          size:
                                              SizeConfig.safeBlockHorizontal *
                                              2.8,
                                          color: Colors.green.shade600,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        SpaceSizer(vertical: 1),

                        // Change Password Section
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 5,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.blueColor,
                                size: SizeConfig.safeBlockHorizontal * 5,
                              ),
                              SpaceSizer(horizontal: 2),
                              RubikTextView(
                                value: 'Ganti Kata Sandi',
                                fontWeight: FontWeight.w600,
                                size: SizeConfig.safeBlockHorizontal * 4.5,
                                color: AppColors.blackColor,
                              ),
                            ],
                          ),
                        ),
                        SpaceSizer(vertical: 1.5),

                        // Change Password Form
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 4,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                CustomTextField(
                                  title: 'Kata Sandi Baru',
                                  hintText: 'Masukkan kata sandi baru',
                                  controller:
                                      frameController.passwordController,

                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: AppColors.blueColor,
                                  ),
                                ),
                                SpaceSizer(vertical: 1.5),
                                CustomTextField(
                                  controller:
                                      frameController.passwordController,
                                  title: 'Konfirmasi Kata Sandi',
                                  hintText: 'Konfirmasi kata sandi baru',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: AppColors.blueColor,
                                  ),
                                ),
                                SpaceSizer(vertical: 1),
                                CustomFlatButton(
                                  text: 'Ganti Kata Sandi',
                                  onTap: () {
                                    frameController.changePassword(
                                      frameController.passwordController.value
                                          .toString(),
                                    );
                                  },
                                  width: SizeConfig.horizontal(100),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Logout Section
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 5,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Colors.red.shade600,
                                size: SizeConfig.safeBlockHorizontal * 5,
                              ),
                              SpaceSizer(horizontal: 2),
                              RubikTextView(
                                value: 'Keluar',
                                fontWeight: FontWeight.w600,
                                size: SizeConfig.safeBlockHorizontal * 4.5,
                                color: Colors.red.shade600,
                              ),
                            ],
                          ),
                        ),
                        SpaceSizer(vertical: 1.5),

                        // Logout Button
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 4,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Logout logic
                              _showLogoutDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.safeBlockVertical * 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.red.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.power_settings_new,
                                      color: Colors.red.shade600,
                                      size: SizeConfig.safeBlockHorizontal * 4,
                                    ),
                                    SpaceSizer(horizontal: 2),
                                    RubikTextView(
                                      value: 'Keluar dari Akun',
                                      fontWeight: FontWeight.w500,
                                      size: SizeConfig.safeBlockHorizontal * 4,
                                      color: Colors.red.shade600,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
      ),
    );
  }

  // Dialog konfirmasi logout
  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange.shade600,
              size: 28,
            ),
            SpaceSizer(horizontal: 2),
            RubikTextView(
              value: 'Konfirmasi Keluar',
              fontWeight: FontWeight.w600,
              size: 18,
              color: AppColors.blackColor,
            ),
          ],
        ),
        content: RubikTextView(
          value: 'Apakah Anda yakin ingin keluar dari akun?',
          fontWeight: FontWeight.w400,
          size: 16,
          color: Colors.grey.shade700,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
            child: RubikTextView(
              value: 'Batal',
              fontWeight: FontWeight.w500,
              size: 14,
              color: Colors.grey.shade600,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Logout logic
              Get.back();
              // Get.offAllNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: RubikTextView(
              value: 'Keluar',
              fontWeight: FontWeight.w600,
              size: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
