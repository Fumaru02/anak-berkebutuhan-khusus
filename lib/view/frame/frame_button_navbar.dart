import 'package:anak_berkebutuhan_khusus/controller/frame_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/asset_list.dart';
import 'package:anak_berkebutuhan_khusus/view/widgets/custom_image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../utils/size_config.dart';

import 'frame_appbar.dart';

class FrameBottomNav extends FrameAppBar {
  const FrameBottomNav({
    super.titleScreen,
    super.heightBar,
    super.color,
    super.isCenter,
    super.elevation,
    super.isUseLeading,
    super.onBack,
    super.customLeading,
    super.action,
    super.isImplyLeading,
    super.customTitle,
    // status bar
    super.statusBarColor,
    super.statusBarIconBrightness,
    super.statusBarBrightness,
    // scaffold
    this.colorScaffold,
    super.key,
  });

  final Color? colorScaffold;

  @override
  Widget build(BuildContext context) {
    final FrameController frameController = Get.put(FrameController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.blackColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: DefaultTabController(
        length: frameController.widgetViewList.length,
        child: Scaffold(
          backgroundColor: colorScaffold,
          extendBody: true,
          resizeToAvoidBottomInset: true,
          appBar: FrameAppBar(
            titleScreen: titleScreen,
            heightBar: heightBar,
            color: color,
            elevation: elevation,
            isCenter: isCenter,
            isUseLeading: isUseLeading,
            onBack: onBack,
            customLeading: customLeading,
            action: action,
            isImplyLeading: isImplyLeading,
            customTitle: customTitle,
            statusBarColor: statusBarColor,
            statusBarIconBrightness: statusBarIconBrightness,
            statusBarBrightness: statusBarBrightness,
          ),
          body: SafeArea(
            bottom: false,
            child: Obx(
              () => IndexedStack(
                index: frameController.defaultIndex.toInt(),
                children: frameController.widgetViewList,
              ),
            ),
          ),
          bottomNavigationBar: frameController.defaultIndex.value != 1
              ? _bottomAppBar(
                  context: context,
                  frameController: frameController,
                )
              : null,
        ),
      ),
    );
  }

  BottomAppBar _bottomAppBar({
    required BuildContext context,
    required FrameController frameController,
  }) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.whiteColor,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        onTap: (int index) {
          return frameController.onTapNav(index);
        },
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        iconSize: 0,
        items: menuLIst(frameController),
      ),
    );
  }

  List<BottomNavigationBarItem> menuLIst(FrameController frameController) {
    return <BottomNavigationBarItem>[
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.homeIcon,
        label: 'Home',
        index: 0,
      ),
      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.moonBtm,
        label: 'History',
        index: 1,
      ),

      _bottomNavigationBarItemDefault(
        frameController: frameController,
        asset: AssetList.profileIcon,
        label: 'Profile',
        index: 2,
      ),
    ];
  }

  BottomNavigationBarItem _bottomNavigationBarItemDefault({
    required String asset,
    required String label,
    required int index,
    required FrameController frameController,
    double? widthIcon,
    double? heightIcon,
  }) {
    return BottomNavigationBarItem(
      icon: _MenuItemWrapper(
        frameController: frameController,
        asset: asset,
        label: label,
        index: index,
        widthIcon: widthIcon,
        heightIcon: heightIcon,
      ),
      label: '',
    );
  }
}

class _MenuItemWrapper extends StatelessWidget {
  const _MenuItemWrapper({
    required this.asset,
    required this.label,
    required this.index,
    this.widthIcon,
    this.heightIcon,
    required this.frameController,
  });

  final String asset;
  final String label;
  final int index;
  final double? widthIcon;
  final double? heightIcon;
  final FrameController frameController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnMainAxisSize: MainAxisSize.min,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: Obx(
            () => Column(
              children: [
                CustomImageAsset(
                  decoration:
                      frameController.onTapIdentifierList[index].isOnTapped
                      ? BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(SizeConfig.horizontal(6)),
                            right: Radius.circular(SizeConfig.horizontal(6)),
                          ),
                        )
                      : null,
                  asset: asset,
                  height: heightIcon ?? 6,
                  color: frameController.onTapIdentifierList[index].isOnTapped
                      ? Colors.amber
                      : AppColors.greyDisabled,
                ),
                RubikTextView(
                  value: label,
                  color: AppColors.blackColor,
                  size: SizeConfig.safeBlockHorizontal * 3,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
