import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/core/utils/constants/app_sizer.dart';

import '../../../../core/utils/constants/app_color.dart';
import '../../controllers/home_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/sort_dropdown.dart';


class SearchScreen extends GetView<HomeController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(
                      onChanged: controller.updateSearchQuery,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SortDropdown(
                    onChanged: controller.updateSortOption,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.inProgress.value && controller.productList.isEmpty) {
                  return const ShimmerLoading();
                }
                if (controller.filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                // Show the product grid
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.currentPage.value = 1;
                      controller.hasMoreData.value = true;
                      await controller.fetchProducts();
                    },
                    child: GridView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: controller.filteredProducts.length +
                          (controller.inProgress.value && controller.productList.isNotEmpty ? 2 : 0),
                      itemBuilder: (context, index) {
                        if (index >= controller.filteredProducts.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final product = controller.filteredProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

