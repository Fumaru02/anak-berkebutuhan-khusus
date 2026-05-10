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
    final AnimatedController animatedController =
        Get.find<AnimatedController>();
    return Obx(
      () => Container(
        width: SizeConfig.horizontal(animatedController.width.toDouble()),
        constraints: BoxConstraints(
          maxHeight: SizeConfig.vertical(70),
          minHeight: SizeConfig.vertical(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: SizeConfig.vertical(
                  animatedController.height.toDouble(),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetList.wavePic),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
