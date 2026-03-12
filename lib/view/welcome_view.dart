import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/frame_apps.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/login_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/welcome_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/white_wave_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

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
            Column(
              children: [
                Spacer(),
                Obx(
                  () => WhiteWaveContainer(
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.horizontal(2)),
                      child: animatedController.onTapped.isFalse
                          ? WelcomeWidget(
                              animatedController: animatedController,
                            )
                          : LoginWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
