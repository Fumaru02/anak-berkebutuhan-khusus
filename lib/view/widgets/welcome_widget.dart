import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key, required this.animatedController});

  final AnimatedController animatedController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSizer(vertical: 4),
        RubikTextView(
          value: 'Deteksi Anak\nBerkebutuhan Khusus',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          size: SizeConfig.safeBlockHorizontal * 8.5,
        ),
        RubikTextView(
          value: 'Lebih Cepat & Tepat',
          color: AppColors.blueColor,
          fontWeight: FontWeight.bold,
          size: SizeConfig.safeBlockHorizontal * 8.5,
        ),
        BlueStrip(),
        SpaceSizer(vertical: 5),
        Row(
          children: [
            Spacer(),
            RippleButton(
              onTap: () => animatedController.toggleAnimate(),
              child: Image.asset(
                AssetList.nextButton,
                width: SizeConfig.horizontal(30),
                height: SizeConfig.horizontal(30),
              ),
            ),
            SpaceSizer(horizontal: 8),
          ],
        ),
      ],
    );
  }
}
