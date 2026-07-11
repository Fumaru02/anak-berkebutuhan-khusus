import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get.dart';

class WhiteWaveContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  const WhiteWaveContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final AnimatedController animatedController =
        Get.find<AnimatedController>();
    return KeyboardSizeProvider(
      child: SizedBox(
        width: SizeConfig.horizontal(
          height ?? animatedController.width.toDouble(),
        ),
        // Hapus constraints atau sesuaikan
        child: AnimatedContainer(
          // Langsung AnimatedContainer, tanpa Flexible
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: SizeConfig.vertical(
            width ?? animatedController.height.toDouble(),
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
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
