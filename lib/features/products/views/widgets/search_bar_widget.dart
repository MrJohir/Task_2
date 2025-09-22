import 'package:flutter/material.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_texts.dart';
import '../../../../core/utils/constants/sizer.dart';

/// Search bar widget for product search functionality
/// Provides text input with search icon and clear functionality
class SearchBarWidget extends StatelessWidget {
  /// Text editing controller for search input
  final TextEditingController controller;

  /// Callback when search text changes
  final ValueChanged<String>? onChanged;

  /// Callback when search is submitted
  final ValueChanged<String>? onSubmitted;

  /// Callback when clear button is pressed
  final VoidCallback? onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Sizer.marginMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
        border: Border.all(color: AppColors.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextStyles.textFieldText,
        decoration: InputDecoration(
          hintText: AppTexts.searchProducts,
          hintStyle: AppTextStyles.textFieldHint,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: Sizer.iconMedium,
          ),
          suffixIcon: _buildClearButton(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusMedium),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusMedium),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusMedium),
            borderSide: BorderSide(color: AppColors.primary, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizer.radiusMedium),
            borderSide: BorderSide(color: AppColors.error, width: 2.0),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Sizer.paddingMedium,
            vertical: Sizer.paddingSmall,
          ),
          filled: true,
          fillColor: AppColors.surface,
        ),
      ),
    );
  }

  /// Build clear button for search field
  /// Shows clear icon when there's text in the search field
  Widget? _buildClearButton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (value.text.isEmpty) {
          return const SizedBox.shrink();
        }

        return IconButton(
          onPressed: () {
            controller.clear();
            onClear?.call();
          },
          icon: Icon(
            Icons.clear,
            color: AppColors.textSecondary,
            size: Sizer.iconMedium,
          ),
          tooltip: AppTexts.clear,
        );
      },
    );
  }
}
