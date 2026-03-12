import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.horizontal(100),
      height: SizeConfig.vertical(50),
      child: Image.asset(AssetList.splashScreen, fit: BoxFit.cover),
    );
  }
}
