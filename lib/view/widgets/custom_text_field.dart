import 'package:anak_berkebutuhan_khusus/controller/welcome_view_controller.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_colors.dart';
import 'package:anak_berkebutuhan_khusus/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../utils/size_config.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.height,
    this.titleFontWeight,
    this.width,
    this.borderRadius,
    this.labelText,
    this.hintText,
    this.textColor,
    this.hintTextColor,
    this.isPasswordField = false,
    this.expands = false,
    this.suffixIcon,
    this.onChanged,
    this.autofillHint,
    this.textInputAction,
    this.contentPadding,
    this.prefixIcon,
    this.controller,
    this.passwordController,
    this.textAlignVertical,
    this.onFieldSubmitted,
    this.minLines,
    this.maxLength,
    this.maxLines,
    this.focusNode,
    this.keyboardType,
  });
  final String title;
  final double? height;
  final FontWeight? titleFontWeight;
  final double? width;
  final double? borderRadius;
  final String? labelText;
  final String? hintText;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isPasswordField;
  final bool expands;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHint;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextEditingController? passwordController;
  final TextAlignVertical? textAlignVertical;
  final Function(String)? onFieldSubmitted;
  final int? minLines;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    final WelcomeViewController welcomeViewController = Get.put(
      WelcomeViewController(),
    );
    return ResponsiveRowColumn(
      layout: ResponsiveRowColumnType.COLUMN,
      columnSpacing: 4,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      children: <ResponsiveRowColumnItem>[
        ResponsiveRowColumnItem(
          child: title == ''
              ? const SizedBox.shrink()
              : RubikTextView(
                  value: title,
                  size: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: titleFontWeight ?? FontWeight.w500,
                  color: textColor ?? AppColors.blackColor,
                ),
        ),
        ResponsiveRowColumnItem(
          child: SizedBox(
            width: SizeConfig.horizontal(width ?? 90),
            height: height ?? SizeConfig.vertical(7),
            // ignore: use_if_null_to_convert_nulls_to_bools
            child: isPasswordField == true
                ? Obx(
                    () => TextFormField(
                      autofillHints: autofillHint,
                      minLines: minLines,
                      controller: passwordController,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      keyboardType: TextInputType.text,
                      textInputAction: textInputAction,
                      // ignore: avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
                      obscureText: isPasswordField == true
                          ? welcomeViewController.isObscurePassword.value =
                                welcomeViewController.isObscurePassword.value
                          : false,
                      decoration: InputDecoration(
                        prefixIcon: prefixIcon,
                        suffixIcon: IconButton(
                          onPressed: () {
                            welcomeViewController.isObscurePassword.value =
                                !welcomeViewController.isObscurePassword.value;
                          },
                          icon: Icon(
                            welcomeViewController.isObscurePassword.isFalse
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: welcomeViewController.isObscurePassword.isFalse
                              ? AppColors.blackColor
                              : AppColors.greyDisabled,
                        ),
                        fillColor: AppColors.whiteColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              SizeConfig.horizontal(borderRadius ?? 4),
                            ),
                          ),
                        ),
                        labelText: hintText,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: RubikStyle().labelStyle(hintTextColor),
                      ),
                    ),
                  )
                : TextFormField(
                    autofillHints: autofillHint,
                    minLines: minLines,
                    controller: controller,
                    textAlignVertical: textAlignVertical,
                    focusNode: focusNode,
                    maxLines: maxLines,
                    textInputAction: textInputAction,
                    onChanged: onChanged,
                    expands: expands,
                    onFieldSubmitted: onFieldSubmitted,
                    keyboardType: keyboardType ?? TextInputType.text,
                    // ignore: avoid_bool_literals_in_conditional_expressions, use_if_null_to_convert_nulls_to_bools
                    decoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      hintMaxLines: 4,
                      fillColor: AppColors.whiteColor,
                      filled: true,

                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyDisabled),
                      ),
                      labelText: labelText,
                      hintText: hintText,
                      hintStyle: RubikStyle().labelStyle(hintTextColor),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: RubikStyle().labelStyle(hintTextColor),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
