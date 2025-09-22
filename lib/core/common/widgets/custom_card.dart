import 'package:flutter/material.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/sizer.dart';

/// Custom card widget with consistent styling
/// Provides a reusable card component for the app
class CustomCard extends StatelessWidget {
  /// Child widget to display inside the card
  final Widget child;

  /// Optional callback when card is tapped
  final VoidCallback? onTap;

  /// Card elevation (optional)
  final double? elevation;

  /// Card margin (optional)
  final EdgeInsetsGeometry? margin;

  /// Card padding (optional)
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.elevation,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? Sizer.cardElevation,
      color: AppColors.cardBackground,
      margin: margin ?? EdgeInsets.all(Sizer.marginSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
        child: Padding(
          padding: padding ?? EdgeInsets.all(Sizer.paddingMedium),
          child: child,
        ),
      ),
    );
  }
}
