import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_2/features/products/views/widgets/search_bar_widget.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_texts.dart';
import '../../../../core/utils/constants/sizer.dart';
import '../../controllers/product_controller.dart';
import '../widgets/category_filter_widget.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/product_shimmer_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppTexts.productListTitle,
          style: AppTextStyles.appBarTitle,
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) {
          return Column(
            children: [
              // Search bar
              SearchBarWidget(
                controller: controller.searchController,
                onChanged: controller.searchProducts,
                onClear: () => controller.searchProducts(''),
              ),

              // Category filter
              Obx(() {
                if (controller.categories.isEmpty) {
                  return const SizedBox.shrink();
                }

                return CategoryFilterWidget(
                  categories: controller.categories,
                  selectedCategory: controller.selectedCategory,
                  onCategoryChanged: controller.filterByCategory,
                );
              }),

              SizedBox(height: Sizer.spacing16),

              // Products grid or loading/error states
              Expanded(child: _buildProductsContent(controller)),
            ],
          );
        },
      ),
    );
  }

  /// Build main products content area
  /// Handles different states: loading, error, empty, and success
  Widget _buildProductsContent(ProductController controller) {
    return Obx(() {
      // Loading state
      if (controller.isLoading) {
        return const ProductShimmerWidget();
      }

      // Error state
      if (controller.hasError) {
        return _buildErrorState(controller);
      }

      // Empty state
      if (controller.isEmpty) {
        return _buildEmptyState();
      }

      // Success state with products
      return _buildProductGrid(controller);
    });
  }

  /// Build error state UI
  /// Shows error message with retry button
  Widget _buildErrorState(ProductController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Sizer.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: AppColors.error),

            SizedBox(height: Sizer.spacing16),

            Text(
              controller.errorMessage,
              style: AppTextStyles.bodyText1,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: Sizer.spacing24),

            ElevatedButton(
              onPressed: controller.loadInitialData,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizer.radiusMedium),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.paddingLarge,
                  vertical: Sizer.paddingMedium,
                ),
              ),
              child: Text(AppTexts.retry, style: AppTextStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }

  /// Build empty state UI
  /// Shows message when no products found
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Sizer.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64.sp, color: AppColors.textSecondary),

            SizedBox(height: Sizer.spacing16),

            Text(
              AppTexts.noProductsFound,
              style: AppTextStyles.headline6,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: Sizer.spacing8),

            Text(
              'Try adjusting your search or filter criteria',
              style: AppTextStyles.bodyText2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build product grid with pull-to-refresh
  /// Shows grid of product cards with refresh functionality
  Widget _buildProductGrid(ProductController controller) {
    return RefreshIndicator(
      onRefresh: controller.refreshProducts,
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: Sizer.paddingMedium),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Sizer.spacing4,
          mainAxisSpacing: Sizer.spacing4,
          childAspectRatio: 0.65,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return ProductCardWidget(
            product: product,
            onTap: () {
              // Add navigation to product details if needed
              debugPrint('Product tapped: ${product.title}');
            },
          );
        },
      ),
    );
  }
}
