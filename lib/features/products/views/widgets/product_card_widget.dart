import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/sizer.dart';
import '../../../../core/utils/helpers/app_helper.dart';
import '../../models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  /// Product data to display
  final Product product;

  /// Optional callback when card is tapped
  final VoidCallback? onTap;

  const ProductCardWidget({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Sizer.cardElevation,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
        child: Padding(
          padding: EdgeInsets.all(Sizer.spacing12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              _buildProductImage(),

              SizedBox(height: Sizer.spacing8),

              // Product title
              Text(
                product.getTruncatedTitle(30),
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: Sizer.spacing8),

              // Product category
              _buildProductCategory(),

              SizedBox(height: Sizer.spacing8),

              // Product price and rating
              _buildPriceAndRating(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build product image section
  /// Shows product image with error and loading handling
  Widget _buildProductImage() {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
        color: AppColors.background,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
        child: Image.network(
          product.image,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return AppHelper.getImageLoadingPlaceholder(
              width: double.infinity,
              height: 100.h,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return AppHelper.getImageErrorPlaceholder(
              width: double.infinity,
              height: 100.h,
            );
          },
        ),
      ),
    );
  }

  /// Build product category section
  /// Shows formatted category name
  Widget _buildProductCategory() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(Sizer.radiusSmall),
      ),
      child: Text(
        product.capitalizedCategory,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Build price and rating section
  /// Shows product price and star rating
  Widget _buildPriceAndRating() {
    return Row(
      children: [
        // Price
        Expanded(
          child: Text(
            product.formattedPrice,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(width: Sizer.spacing4),

        // Rating
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: AppColors.secondary, size: 12.sp),

            SizedBox(width: 2.w),

            Text(
              product.rating.rate.toStringAsFixed(1),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
