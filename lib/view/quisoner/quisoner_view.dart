import 'package:anak_berkebutuhan_khusus/controller/animated_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/utils/enums.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/view/frame/frame_scaffold.dart';
import 'package:anak_berkebutuhan_khusus/view/quisoner/widget/quisoner.dart';
import 'package:anak_berkebutuhan_khusus/view/quisoner/widget/quisoner_welcome.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/register_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/login_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/welcome_widget.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/white_wave_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuisonerView extends StatelessWidget {
  const QuisonerView({super.key});

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

            Column(
              children: [
                Spacer(),
                Obx(
                  () => WhiteWaveContainer(
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.horizontal(2)),
                      child: () {
                        switch (animatedController.currentState.value) {
                          case AnimState.animate:
                            return LoginWidget(
                              animatedController: animatedController,
                            );
                          case AnimState.daftar:
                            return Quisoner(
                              animatedController: animatedController,
                            );
                          case AnimState.none:
                            return QuisonerWelcome(
                              animatedController: animatedController,
                            );
                        }
                      }(),
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
