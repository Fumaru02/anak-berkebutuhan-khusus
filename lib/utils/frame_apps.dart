import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FrameScaffold extends StatelessWidget {
  // constructor
  const FrameScaffold({
    super.key,
    // parameter for app bar
    // parameter for scaffold
    // system status bar
    this.view,
    this.bottomSheet,
    this.avoidBottomInset,
    this.elevation,
    this.heightBar,
    this.color,
    this.colorScaffold,
    this.isCenter,
    this.isUseLeading,
    this.isImplyLeading,
    this.customLeading,
    this.action,
    this.customTitle,
    this.bottomNavBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.titleScreen,
    this.onBack,
    this.bottom,
    this.gradient,
    this.statusBarColor,
    this.statusBarBrightness,
    this.statusBarIconBrightness,
  });

  // parameter for scaffold
  final Widget? view;
  final Widget? bottomSheet;
  final bool? avoidBottomInset;

  //Appbar parameter double
  final double? elevation;
  final double? heightBar;
  //Appbar parameter Color
  final Color? color;
  final Color? colorScaffold;
  //Appbar parameter bool
  final bool? isCenter;
  final bool? isUseLeading;
  final bool? isImplyLeading;
  //Appbar constructor Widget
  final Widget? customLeading;
  final Widget? action;
  final Widget? customTitle;
  final Widget? bottomNavBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  //Appbar constructor
  final String? titleScreen;
  final dynamic Function()? onBack;
  final PreferredSizeWidget? bottom;
  final LinearGradient? gradient;
  // system status bar
  final Color? statusBarColor;
  // system status bar Brightness
  final Brightness? statusBarBrightness;
  final Brightness? statusBarIconBrightness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: colorScaffold ?? Colors.white,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: FrameAppBar(
        titleScreen: titleScreen,
        heightBar: heightBar,
        color: color,
        isCenter: isCenter,
        elevation: elevation,
        gradient: gradient,
        isUseLeading: isUseLeading,
        onBack: onBack,
        customLeading: customLeading,
        action: action,
        isImplyLeading: isImplyLeading,
        customTitle: customTitle,
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
        bottom: bottom,
      ),
      bottomSheet: bottomSheet,
      body: view,
      bottomNavigationBar: bottomNavBar,
    );
  }
}

class FrameAppBar extends StatelessWidget implements PreferredSizeWidget {
  // constructor
  const FrameAppBar({
    super.key,
    // status bar
    this.action,
    this.customLeading,
    this.customTitle,
    this.heightBar,
    this.elevation,
    this.isCenter,
    this.isUseLeading,
    this.isImplyLeading,
    this.color,
    this.onBack,
    this.titleScreen,
    this.bottom,
    this.gradient,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.statusBarBrightness,
  });

  /// [Parameter]
  //Widget
  final Widget? action;
  final Widget? customLeading;
  final Widget? customTitle;
  //double
  final double? heightBar;
  final double? elevation;
  //boolean
  final bool? isCenter;
  final bool? isUseLeading;
  final bool? isImplyLeading;
  //Widget Color
  final Color? color;
  //Function
  final Function()? onBack;
  //String
  final String? titleScreen;
  //PrefferedSizeWidget
  final PreferredSizeWidget? bottom;
  final LinearGradient? gradient;

  // status bar
  final Color? statusBarColor;
  final Brightness? statusBarIconBrightness;
  final Brightness? statusBarBrightness;

  Widget _titleScreen() {
    if (titleScreen == null && isImplyLeading == null) {
      return const SizedBox.shrink();
    } else if (titleScreen == null && isImplyLeading == false) {
      return customTitle ?? const Text('');
    } else {
      return RubikTextView(
        value: titleScreen ?? '',
        fontWeight: FontWeight.bold,
        color: Colors.white,
        size: SizeConfig.safeBlockHorizontal * 5,
      );
    }
  }

  Widget _leadingWrapper(BuildContext context) {
    if (customLeading == null) {
      return _backButton(context);
    } else {
      return customLeading!;
    }
  }

  Widget _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        onBack == null ? Get.back() : onBack!();
      },
      icon: Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  bool _enableImplyLeading() {
    if (isImplyLeading == null) {
      return true;
    } else if (isImplyLeading == false) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AppBar(
      flexibleSpace: Container(color: Colors.transparent),
      title: _titleScreen(),
      backgroundColor: color ?? Colors.white,
      centerTitle: isCenter ?? false,
      elevation: elevation,
      bottomOpacity: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.white,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
        // iOS
        statusBarBrightness: statusBarBrightness ?? Brightness.light,
      ),
      leading: isUseLeading == null || isUseLeading == false
          ? null
          : _leadingWrapper(context),
      actions: <Widget>[action ?? const SizedBox.shrink()],
      automaticallyImplyLeading: _enableImplyLeading(),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(heightBar ?? kToolbarHeight);
}
