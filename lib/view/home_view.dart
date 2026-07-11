import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/frame_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/explain_view.dart';
import 'package:anak_berkebutuhan_khusus/view/quisoner/quisoner_view.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimatedController animatedController = Get.put(AnimatedController());
    final FrameController frameController = Get.put(FrameController());

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.blueColor,
        body: Stack(
          children: [
            // Background dengan gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blueColor,
                    AppColors.blueColor.withOpacity(0.8),
                    Colors.white,
                  ],
                  stops: [0.0, 0.3, 0.7],
                ),
              ),
            ),

            // Background pattern (opsional)
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal * 4,
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header dengan moon icon dan profile
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Greeting Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RubikTextView(
                                  value:
                                      'Halo, ${frameController.userName.value}',
                                  fontWeight: FontWeight.bold,
                                  size: SizeConfig.safeBlockHorizontal * 6,
                                  color: Colors.white,
                                ),
                                SpaceSizer(vertical: 0.5),
                                RubikTextView(
                                  value: 'Selamat datang kembali! 👋',
                                  fontWeight: FontWeight.w400,
                                  size: SizeConfig.safeBlockHorizontal * 3.5,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ),

                            // Profile Avatar & Moon Icon
                            Row(
                              children: [
                                // Moon Icon
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.asset(
                                    AssetList.moonIcon,
                                    height: SizeConfig.safeBlockHorizontal * 5,
                                    width: SizeConfig.safeBlockHorizontal * 5,
                                    color: Colors.white,
                                  ),
                                ),
                                SpaceSizer(horizontal: 2),

                                // Profile Avatar
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      // Navigate to profile
                                      // Get.to(() => ProfileView());
                                    },
                                    child: Container(
                                      width: SizeConfig.horizontal(12),
                                      height: SizeConfig.horizontal(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 10,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: frameController.isLoading.value
                                          ? Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            )
                                          : frameController
                                                .userImage
                                                .value
                                                .isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: CachedNetworkImage(
                                                imageUrl: frameController
                                                    .userImage
                                                    .value,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      child: Icon(
                                                        Icons.person,
                                                        color: Colors
                                                            .grey
                                                            .shade600,
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          color: Colors
                                                              .grey
                                                              .shade300,
                                                          child: Icon(
                                                            Icons.person,
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                          ),
                                                        ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.person_rounded,
                                                color: Colors.grey.shade600,
                                                size: SizeConfig.horizontal(7),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SpaceSizer(vertical: 4),

                        // Hero Card - Start Detection
                        Container(
                          width: double.infinity,
                          height: SizeConfig.horizontal(50),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.white, Colors.grey.shade50],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Background decoration
                              Positioned(
                                right: -20,
                                top: -20,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.blueColor.withOpacity(
                                      0.05,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -30,
                                bottom: -30,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: AppColors.blueColor.withOpacity(
                                      0.05,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),

                              // Content
                              Padding(
                                padding: EdgeInsets.all(
                                  SizeConfig.safeBlockHorizontal * 5,
                                ),
                                child: Row(
                                  children: [
                                    // Left side - Text
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RubikTextView(
                                            value: 'Mulai Deteksi',
                                            fontWeight: FontWeight.bold,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                5.5,
                                            color: AppColors.blackColor,
                                          ),
                                          SpaceSizer(vertical: 1),
                                          RubikTextView(
                                            value:
                                                'Cari tahu potensi\nanak berkebutuhan khusus',
                                            fontWeight: FontWeight.w400,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                3.2,
                                            color: Colors.grey.shade700,
                                          ),
                                          SpaceSizer(vertical: 2),
                                          CustomFlatButton(
                                            text: 'Mulai Sekarang',
                                            onTap: () {
                                              Get.to(() => QuisonerView());
                                              animatedController
                                                  .resetAnimation();
                                            },
                                            width: 50,
                                            height: 4,
                                            radius: 2,
                                            textSize: 3.2,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Right side - Image/Icon
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 100,
                                        child: Icon(
                                          Icons.psychology_rounded,
                                          color: AppColors.blueColor
                                              .withOpacity(0.3),
                                          size: 80,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SpaceSizer(vertical: 4),

                        // Education Section Title
                        Row(
                          children: [
                            Icon(
                              Icons.school_rounded,
                              color: Colors.white,
                              size: SizeConfig.safeBlockHorizontal * 5,
                            ),
                            SpaceSizer(horizontal: 2),
                            RubikTextView(
                              value: 'Edukasi & Informasi',
                              fontWeight: FontWeight.bold,
                              size: SizeConfig.safeBlockHorizontal * 4.5,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        SpaceSizer(vertical: 2),

                        // Education Grid
                        frameController.isLoading.value
                            ? Container(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      SpaceSizer(vertical: 2),
                                      RubikTextView(
                                        value: 'Memuat data edukasi...',
                                        fontWeight: FontWeight.w400,
                                        size:
                                            SizeConfig.safeBlockHorizontal *
                                            3.5,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : frameController.educationsList.isEmpty
                            ? Container(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.school_outlined,
                                        size: 50,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      SpaceSizer(vertical: 2),
                                      RubikTextView(
                                        value: 'Belum ada edukasi tersedia',
                                        fontWeight: FontWeight.w400,
                                        size:
                                            SizeConfig.safeBlockHorizontal *
                                            3.5,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing:
                                          SizeConfig.safeBlockVertical * 2,
                                      crossAxisSpacing:
                                          SizeConfig.safeBlockHorizontal * 3,
                                      childAspectRatio: 0.8,
                                    ),
                                itemCount:
                                    frameController.educationsList.length > 4
                                    ? 4
                                    : frameController.educationsList.length,
                                itemBuilder: (context, index) {
                                  final education =
                                      frameController.educationsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => ExplainView(
                                          educationModel: education,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 10,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Image
                                          Expanded(
                                            flex: 3,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                              child: CachedNetworkImage(
                                                imageUrl: education.sourceImage,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                placeholder: (context, url) =>
                                                    Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      child: Icon(
                                                        Icons.image_outlined,
                                                        color: Colors
                                                            .grey
                                                            .shade400,
                                                        size: 30,
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (
                                                      context,
                                                      url,
                                                      error,
                                                    ) => Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      child: Icon(
                                                        Icons
                                                            .broken_image_outlined,
                                                        color: Colors
                                                            .grey
                                                            .shade400,
                                                        size: 30,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          // Title
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                SizeConfig.safeBlockHorizontal *
                                                    2,
                                              ),
                                              child: RubikTextView(
                                                value: education.title,
                                                fontWeight: FontWeight.w600,
                                                size:
                                                    SizeConfig
                                                        .safeBlockHorizontal *
                                                    3.2,
                                                color: AppColors.blackColor,
                                                maxLines: 2,
                                                overFlow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                        SpaceSizer(vertical: 4),

                        // Footer
                        Center(
                          child: RubikTextView(
                            value: '© 2024 ABK Detection App',
                            fontWeight: FontWeight.w400,
                            size: SizeConfig.safeBlockHorizontal * 2.8,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),

                        SpaceSizer(vertical: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
