import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/frame/frame_scaffold.dart';
import 'package:anak_berkebutuhan_khusus/view/quisoner/widget/quisoner.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimatedController animatedController = Get.put(AnimatedController());
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
            Container(
              height: SizeConfig.screenHeight,
              color: AppColors.whiteColor,
              child: PageView(
                children: [
                  History(),
                  IndicationPartHistory(animatedController: animatedController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndicationPartHistory extends StatelessWidget {
  const IndicationPartHistory({super.key, required this.animatedController});

  final AnimatedController animatedController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.horizontal(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 12),
          RubikTextView(
            value: 'History',
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 10,
            color: AppColors.blackColor,
          ),
          BlueStrip(),

          SpaceSizer(vertical: 1),
          RubikTextView(
            value: 'Indikasi',
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 6,
            color: AppColors.blackColor,
          ),

          SpaceSizer(vertical: 1),
          RubikTextView(
            value:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry?',
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 5,
            color: AppColors.blackColor,
          ),
          SpaceSizer(vertical: 5),
          Center(
            child: Column(
              children: [SpaceSizer(vertical: 2), SpaceSizer(vertical: 4)],
            ),
          ),
        ],
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSizer(vertical: 3),
        RubikTextView(
          value: 'History',
          fontWeight: FontWeight.w500,
          size: SizeConfig.safeBlockHorizontal * 10,
          color: AppColors.blackColor,
        ),
        SpaceSizer(vertical: 2),
        BlueStrip(),
        SpaceSizer(vertical: 2),
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.blackColor,
                width: SizeConfig.safeBlockHorizontal * 0.8,
              ),
              color: AppColors.blueColor,
              borderRadius: BorderRadius.circular(SizeConfig.horizontal(2)),
            ),
            width: SizeConfig.horizontal(80),
            height: SizeConfig.horizontal(30),
            child: Column(
              children: [
                SpaceSizer(vertical: 1),

                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.horizontal(2)),
                  child: RubikTextView(
                    value:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    fontWeight: FontWeight.w500,
                    size: SizeConfig.safeBlockHorizontal * 4,
                    color: AppColors.whiteColor,
                  ),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    RubikTextView(
                      value: 'Lorem Ipsum',
                      fontWeight: FontWeight.w500,
                      size: SizeConfig.safeBlockHorizontal * 4,
                      color: AppColors.whiteColor,
                    ),
                    SpaceSizer(horizontal: 1),
                  ],
                ),
                SpaceSizer(vertical: 1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
