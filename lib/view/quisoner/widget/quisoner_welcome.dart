import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/controller/quisoner_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/utils/space_sizer.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/blue_strip.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_flatbutton.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/ripple_button.dart';
import 'package:flutter/material.dart';

class QuisonerWelcome extends StatelessWidget {
  const QuisonerWelcome({
    super.key,
    required this.animatedController,
    required this.quisonerController,
  });

  final AnimatedController animatedController;
  final QuisonerController quisonerController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpaceSizer(vertical: 8),
          RubikTextView(
            value: 'Mulai Deteksi Anak\nBerkebutuhan Khusus',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            size: SizeConfig.safeBlockHorizontal * 9,
            alignText: AlignTextType.center,
          ),
          SpaceSizer(vertical: 1),

          BlueStrip(),
          SpaceSizer(vertical: 5),
          CustomFlatButton(
            text: 'Mulai',
            onTap: () async {
              await quisonerController.getQuisoners();
              animatedController.toggleAnimateQuisoner();
            },
          ),
        ],
      ),
    );
  }
}
