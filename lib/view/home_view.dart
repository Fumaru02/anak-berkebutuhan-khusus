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
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    AnimatedController animatedController = Get.put(AnimatedController());
    FrameController frameController = Get.put(FrameController());
    return Stack(
      children: [
        Column(
          children: [
            SpaceSizer(vertical: 6),
            Row(
              children: [
                SpaceSizer(horizontal: 10),
                Image.asset(AssetList.moonIcon),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal(6)),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withAlpha(50),
                          borderRadius: BorderRadius.all(
                            Radius.circular(SizeConfig.horizontal(3)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.horizontal(2)),
                          child: RubikTextView(
                            value: frameController.userName.value,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            size: SizeConfig.safeBlockHorizontal * 6.5,
                          ),
                        ),
                      ),
                      // Obx(
                      //   () => frameController.isLoading.isTrue
                      //       ? const Center(child: CircularProgressIndicator())
                      //       : frameController.userImage.value == ''
                      //       ? CircleAvatar(
                      //           minRadius: 30,
                      //           child: Icon(
                      //             Icons.person_2_rounded,
                      //             size: SizeConfig.horizontal(10),
                      //           ),
                      //         )
                      //       : Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(SizeConfig.horizontal(20)),
                      //             ),
                      //             // ignore: use_if_null_to_convert_nulls_to_bools
                      //           ),
                      //           width: SizeConfig.horizontal(20),
                      //           height: SizeConfig.horizontal(20),
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(SizeConfig.horizontal(20)),
                      //             ),
                      //             child: CachedNetworkImage(
                      //               imageUrl: frameController.userImage.value,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //         ),
                      // ),
                    ],
                  ),
                  SpaceSizer(vertical: 2),

                  Container(
                    width: SizeConfig.horizontal(90),
                    height: SizeConfig.horizontal(55),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AssetList.splashScreen),
                        fit: BoxFit.cover,
                      ),
                      color: AppColors.maroon,
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.horizontal(1.5)),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RubikTextView(
                          value: 'Mulai deteksi anak berkebutuhan khusus',
                          size: SizeConfig.safeBlockHorizontal * 8.5,
                          fontWeight: FontWeight.w600,
                          alignText: AlignTextType.center,
                        ),
                        SpaceSizer(vertical: 2),
                        CustomFlatButton(
                          text: 'Mulai',
                          onTap: () {
                            Get.to(QuisonerView());
                            animatedController.resetAnimation();
                          },
                          width: 45,
                          height: 4,
                          radius: 1,
                        ),
                      ],
                    ),
                  ),
                  SpaceSizer(vertical: 6),
                  frameController.isLoading.value == true
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: SizeConfig.horizontal(100),
                          width: SizeConfig.vertical(100),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      2, // number of items in each row
                                  mainAxisSpacing: 40, // spacing between rows
                                  crossAxisSpacing:
                                      18, // spacing between columns
                                ),

                            itemCount: frameController
                                .educationsList
                                .length, // total number of items
                            itemBuilder: (context, index) {
                              return Obx(
                                () => Column(
                                  children: [
                                    RippleButton(
                                      onTap: () => Get.to(
                                        ExplainView(
                                          educationModel: frameController
                                              .educationsList[index],
                                        ),
                                      ),

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.red, // color of grid items
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              SizeConfig.horizontal(1),
                                            ),
                                          ),
                                        ),
                                        height: SizeConfig.vertical(12),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            width: SizeConfig.screenWidth,
                                            imageUrl: frameController
                                                .educationsList[index]
                                                .sourceImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.horizontal(40),
                                      child: RubikTextView(
                                        alignText: AlignTextType.center,
                                        value: frameController
                                            .educationsList[index]
                                            .title,
                                        fontWeight: FontWeight.w600,
                                        size:
                                            SizeConfig.safeBlockHorizontal *
                                            3.5,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
