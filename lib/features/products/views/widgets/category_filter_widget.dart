import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_texts.dart';
import '../../../../core/utils/constants/sizer.dart';
import '../../controllers/product_controller.dart';

/// Category filter dropdown widget
/// Allows users to filter products by category
class CategoryFilterWidget extends StatelessWidget {
  /// List of available categories
  final List<String> categories;

  /// Currently selected category
  final String selectedCategory;

  /// Callback when category selection changes
  final ValueChanged<String> onCategoryChanged;

  const CategoryFilterWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizer.marginMedium),
      padding: EdgeInsets.symmetric(horizontal: Sizer.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory.isEmpty ? '' : selectedCategory,
          hint: Text(
            AppTexts.selectCategory,
            style: AppTextStyles.textFieldHint,
          ),
          style: AppTextStyles.textFieldText,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
            size: Sizer.iconMedium,
          ),
          isExpanded: true,
          dropdownColor: AppColors.surface,
          items: _buildDropdownItems(),
          onChanged: (String? value) {
            if (value != null) {
              onCategoryChanged(value);
            }
          },
        ),
      ),
    );
  }

  /// Build dropdown menu items
  /// Creates items for all categories plus "All Categories" option
  List<DropdownMenuItem<String>> _buildDropdownItems() {
    final List<DropdownMenuItem<String>> items = [
      // All categories option
      DropdownMenuItem<String>(
        value: '',
        child: Row(
          children: [
            Icon(Icons.apps, color: AppColors.primary, size: Sizer.iconSmall),
            SizedBox(width: Sizer.spacing8),
            Text(
              AppTexts.allCategories,
              style: AppTextStyles.bodyText2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ];

    // Add category items
    for (String category in categories) {
      items.add(
        DropdownMenuItem<String>(
          value: category,
          child: Row(
            children: [
              Icon(
                _getCategoryIcon(category),
                color: AppColors.textSecondary,
                size: Sizer.iconSmall,
              ),
              SizedBox(width: Sizer.spacing8),
              Expanded(
                child: Text(
                  Get.find<ProductController>().getCategoryDisplayName(
                    category,
                  ),
                  style: AppTextStyles.bodyText2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  /// Get appropriate icon for category
  /// [category] - Category name
  /// Returns corresponding icon for the category
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'jewelery':
        return Icons.diamond;
      case "men's clothing":
        return Icons.man;
      case "women's clothing":
        return Icons.woman;
      default:
        return Icons.category;
    }
  }
}
