import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokapos/core/design_system/styles/app_colors.dart';
import 'package:yokapos/core/design_system/styles/app_spacing.dart';
import 'package:yokapos/core/design_system/styles/app_typography.dart';

/// Yokapos Design System - Reusable UI Components
/// This file contains all the reusable UI components for the app
class AppComponents {
  // ========================================
  // BUTTONS
  // ========================================

  /// Primary button with gradient background
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    double? width,
    double height = 48,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.gradientButtonPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
                text,
                style: AppTypography.buttonMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: AppTypography.bold,
                ),
              ),
      ),
    );
  }

  /// Secondary button with outline
  static Widget secondaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    double? width,
    double height = 48,
    EdgeInsetsGeometry? padding,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary50,
          side: const BorderSide(color: AppColors.primary50, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary50,
                  ),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Noto Sans',
                ),
              ),
      ),
    );
  }

  /// Text button
  static Widget textButton({
    required String text,
    required VoidCallback onPressed,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: AppTypography.bodyMedium.copyWith(
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }

  // ========================================
  // INPUT FIELDS
  // ========================================

  /// Standard text input field
  static Widget textField({
    String? label,
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    int? maxLines,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(color: AppColors.neutral70),
          ),
        AppSpacing.gapVerticalSm,
        TextFormField(
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          style: AppTypography.bodySmall,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primary30,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error50, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error50, width: 2),
            ),
            hintStyle: AppTypography.bodySmall.copyWith(
              color: AppColors.neutral50.withValues(alpha: 0.5),
            ),
            contentPadding: AppSpacing.inputPadding,
          ),
        ),
      ],
    );
  }

  // ========================================
  // LOADING INDICATORS
  // ========================================

  /// Loading spinner with custom color
  static Widget loadingSpinner({
    Color? color,
    double? size,
    double strokeWidth = 2,
  }) {
    return SizedBox(
      width: size ?? 24,
      height: size ?? 24,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary50),
      ),
    );
  }

  /// Skeleton loading for cards
  static Widget skeletonCard({double height = 120, double? width}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.neutral30,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary50),
        ),
      ),
    );
  }

  // ========================================
  // DIVIDERS
  // ========================================

  /// Standard divider
  static Widget divider({
    double? thickness,
    Color? color,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        thickness: thickness ?? 1,
        color: color ?? AppColors.neutral50,
      ),
    );
  }

  /// Vertical divider
  static Widget verticalDivider({
    double? thickness,
    Color? color,
    double? height,
  }) {
    return Container(
      height: height ?? 24,
      width: thickness ?? 1,
      color: color ?? AppColors.neutral50,
    );
  }

  /// Divider Text
  static Widget dividerText({
    required String text,
    double? thickness,
    Color? color,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: thickness ?? 1,
              color: color ?? AppColors.inputBorder,
            ),
          ),
          Padding(
            padding: AppSpacing.horizontalMd,
            child: Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: color ?? AppColors.neutral50.withValues(alpha: 0.6),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: thickness ?? 1,
              color: color ?? AppColors.inputBorder,
            ),
          ),
        ],
      ),
    );
  }

  /// Logo Button
  static Widget logoButton({required String logo}) {
    return Container(
      padding: AppSpacing.buttonPadding,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.iconBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(logo),
    );
  }
}

/// Badge types for status badges
enum BadgeType { success, error, warning, info, primary }
