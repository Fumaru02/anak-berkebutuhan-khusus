import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/login_view_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_text_field.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quisoner extends StatelessWidget {
  const Quisoner({super.key, required this.animatedController});

  final AnimatedController animatedController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginViewController(),
      builder: (loginViewController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceSizer(vertical: 7),
          RippleButton(
            onTap: () => animatedController.toggleAnimate(),
            child: Image.asset(
              AssetList.kembaliIcon,
              width: SizeConfig.horizontal(30),
              height: SizeConfig.horizontal(10),
            ),
          ),
          SpaceSizer(vertical: 1),
          RubikTextView(
            value: 'Quisoner',
            fontWeight: FontWeight.w500,
            size: SizeConfig.safeBlockHorizontal * 10,
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
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) => Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.all(
                              Radius.circular(SizeConfig.horizontal(2)),
                            ),
                            border: Border.all(color: AppColors.blackColor),
                          ),
                          width: SizeConfig.horizontal(90),
                          height: SizeConfig.horizontal(15),
                          child: RubikTextView(
                            value:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry?',
                            fontWeight: FontWeight.w500,
                            size: SizeConfig.safeBlockHorizontal * 4,
                            color: AppColors.blackColor,
                          ),
                        ),
                        SpaceSizer(vertical: 1),
                      ],
                    ),
                  ),
                ),
                SpaceSizer(vertical: 8),

                CustomFlatButton(
                  text: 'Masuk',
                  onTap: () => animatedController.toggleAnimateQuisoner(),
                ),
                SpaceSizer(vertical: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
