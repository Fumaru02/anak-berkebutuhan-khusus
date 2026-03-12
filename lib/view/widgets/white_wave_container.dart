import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhiteWaveContainer extends StatelessWidget {
  final Widget child;
  const WhiteWaveContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final AnimatedController animatedController = Get.put(AnimatedController());
    return Obx(
      () => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: SizeConfig.horizontal(animatedController.width.toDouble()),
        height: SizeConfig.vertical(animatedController.height.toDouble()),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetList.wavePic),
            fit: BoxFit.fill,
          ),
        ),
        child: child,
      ),
    );
  }
}
