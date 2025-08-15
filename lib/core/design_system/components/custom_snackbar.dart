import 'package:flutter/material.dart';
import 'package:yokapos/core/design_system/styles/app_colors.dart';

void customSnackbar(
  BuildContext context,
  String value, {
  bool isSuccess = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: (isSuccess) ? AppColors.success50 : AppColors.error50,
      content: Text(value),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
