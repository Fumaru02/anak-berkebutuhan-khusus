import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class RippleButton extends StatelessWidget {
  const RippleButton({
    super.key,
    required this.onTap,
    this.radius,
    this.splashColor,
    this.borderRadius,
    this.child,
  });

  final Function() onTap;
  final double? radius;
  final Color? splashColor;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ClipRRect(
      borderRadius:
          borderRadius ??
          BorderRadius.all(Radius.circular(SizeConfig.horizontal(radius ?? 3))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor ?? AppColors.greyDisabled,
          onTap: onTap,
          child: Ink(color: Colors.transparent, child: child),
        ),
      ),
    );
  }
}
