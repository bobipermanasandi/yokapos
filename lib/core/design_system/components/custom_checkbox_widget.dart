import 'package:flutter/material.dart';
import 'package:yokapos/core/design_system/styles/app_colors.dart';
import 'package:yokapos/core/design_system/styles/app_typography.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final String label;
  final bool isValue;
  final Function(bool?)? onChanged;
  const CustomCheckboxWidget({
    super.key,
    required this.label,
    required this.isValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.zero,
          height: 40,
          width: 30,
          child: Checkbox(
            checkColor: AppColors.white,
            activeColor: AppColors.primary50,
            value: isValue,
            side: BorderSide(color: AppColors.neutral30, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }
}
