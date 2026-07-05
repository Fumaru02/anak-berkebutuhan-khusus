import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/models/educations/education_model.dart';
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ExplainView extends StatelessWidget {
  const ExplainView({required this.educationModel, super.key});

  final EducationModel educationModel;

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
        view: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight,
                color: AppColors.whiteColor,
                child: History(educationModel: educationModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({super.key, required this.educationModel});

  final EducationModel educationModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 8),
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
              width: SizeConfig.horizontal(95),
              height: SizeConfig.horizontal(50),
              child: CachedNetworkImage(
                width: SizeConfig.screenWidth,
                imageUrl: educationModel.sourceImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SpaceSizer(vertical: 4),
          Container(
            color: AppColors.blueColor,
            width: SizeConfig.screenWidth,
            child: Center(
              child: RubikTextView(
                value: educationModel.title,
                fontWeight: FontWeight.w500,
                size: SizeConfig.safeBlockHorizontal * 5,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          SpaceSizer(vertical: 2),
          BlueStrip(),
          SpaceSizer(vertical: 2),
          RubikTextView(
            value: educationModel.ask,
            size: SizeConfig.safeBlockHorizontal * 4.5,
            color: AppColors.blackColor,
          ),
          SpaceSizer(vertical: 1),
          Html(data: educationModel.ask1),
          SpaceSizer(vertical: 1),
          Container(
            color: AppColors.blueColor,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
              child: RubikTextView(
                value: educationModel.tanda,
                size: SizeConfig.safeBlockHorizontal * 4.5,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SpaceSizer(vertical: 1),

          BlueStrip(),

          Html(data: educationModel.tanda1),
          SpaceSizer(vertical: 1),
          Container(
            color: AppColors.blueColor,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
              child: RubikTextView(
                value: educationModel.gejala,
                size: SizeConfig.safeBlockHorizontal * 4.5,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SpaceSizer(vertical: 1),

          BlueStrip(),

          Html(data: educationModel.gejala1),
          SpaceSizer(vertical: 1),
          Container(
            color: AppColors.blueColor,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
              child: RubikTextView(
                value: educationModel.penyebab,
                size: SizeConfig.safeBlockHorizontal * 4.5,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SpaceSizer(vertical: 1),

          BlueStrip(),

          Html(data: educationModel.penyebab1),
          SpaceSizer(vertical: 1),
          Container(
            color: AppColors.blueColor,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
              child: RubikTextView(
                value: educationModel.penanganan,
                size: SizeConfig.safeBlockHorizontal * 4.5,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SpaceSizer(vertical: 1),

          BlueStrip(),

          Html(data: educationModel.penanganan1),
          SpaceSizer(vertical: 1),
          Container(
            color: AppColors.blueColor,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal(2)),
              child: RubikTextView(
                value: educationModel.diingat,
                size: SizeConfig.safeBlockHorizontal * 4.5,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SpaceSizer(vertical: 1),

          BlueStrip(),

          Container(
            color: AppColors.greenColor,
            child: Html(data: educationModel.diingat1),
          ),
          SpaceSizer(vertical: 8),
        ],
      ),
    );
  }
}
