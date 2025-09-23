import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/sizer.dart';

class ProductShimmerWidget extends StatelessWidget {
  /// Number of shimmer items to show
  final int itemCount;

  const ProductShimmerWidget({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1600),
      direction: ShimmerDirection.ltr,
      child: GridView.builder(
        padding: EdgeInsets.all(Sizer.paddingMedium),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Sizer.spacing12,
          mainAxisSpacing: Sizer.spacing12,
          childAspectRatio: 0.65,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => _buildShimmerCard(index),
      ),
    );
  }

  /// Build individual shimmer card
  /// Creates skeleton structure matching product card layout
  Widget _buildShimmerCard(int index) {
    // Add variation to placeholder widths for more realistic effect
    final variations = [
      {
        'titleWidth': double.infinity,
        'titleWidth2': 100.w,
        'categoryWidth': 80.w,
      },
      {
        'titleWidth': double.infinity,
        'titleWidth2': 140.w,
        'categoryWidth': 60.w,
      },
      {
        'titleWidth': double.infinity,
        'titleWidth2': 110.w,
        'categoryWidth': 75.w,
      },
    ];
    final variation = variations[index % variations.length];
    return Card(
      elevation: Sizer.cardElevation,
      color: AppColors.cardBackground,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizer.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(Sizer.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(Sizer.radiusMedium),
              ),
            ),

            SizedBox(height: Sizer.spacing4),

            // Title placeholder
            Container(
              height: 14.h,
              width: variation['titleWidth'] as double,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(Sizer.radiusSmall),
              ),
            ),

            SizedBox(height: Sizer.spacing4),

            // Second title line placeholder
            Container(
              height: 14.h,
              width: variation['titleWidth2'] as double,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(Sizer.radiusSmall),
              ),
            ),

            SizedBox(height: Sizer.spacing4),

            // Category placeholder
            Container(
              height: 18.h,
              width: variation['categoryWidth'] as double,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(Sizer.radiusSmall),
              ),
            ),

            SizedBox(height: Sizer.spacing4),

            // Price and rating row placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price placeholder
                Flexible(
                  child: Container(
                    height: 16.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(Sizer.radiusSmall),
                    ),
                  ),
                ),

                SizedBox(width: Sizer.spacing4),

                // Rating placeholder
                Flexible(
                  child: Container(
                    height: 14.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(Sizer.radiusSmall),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
