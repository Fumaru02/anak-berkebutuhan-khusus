import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:flutter/material.dart';

class BlueStrip extends StatelessWidget {
  const BlueStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.horizontal(18),
      height: SizeConfig.horizontal(1),
      color: AppColors.blueColor,
    );
  }
}
