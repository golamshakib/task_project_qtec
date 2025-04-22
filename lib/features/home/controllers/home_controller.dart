import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/product_models.dart';
import '../../../core/services/api_end_point.dart';
import '../../../core/services/network_service.dart';
import '../../../core/services/newtwork_caller.dart';
import '../../../core/utils/logging/logger.dart';
import '../../../core/services/db_helper.dart';

class HomeController extends GetxController {
  final RxList<Product> productList = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool inProgress = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxString searchQuery = ''.obs;
  final RxString sortOption = 'featured'.obs;
  final ScrollController scrollController = ScrollController();
  final NetworkService networkService = NetworkService();
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    super.onInit();
    networkService.monitorConnectivity();
    fetchProducts();
    setupScrollListener();
    fetchDataBasedOnConnection();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void fetchDataBasedOnConnection() async {
    if (await networkService.isConnectedToInternet()) {
      fetchProducts();
    } else {
      Get.snackbar(
        'No Internet',
        'Fetching data from local storage...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      _loadProductsFromDb();
    }
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!inProgress.value && hasMoreData.value) {
          loadMoreProducts();
        }
      }
    });
  }

  /// Update the search query and filter products
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  /// Update the sort option and filter products
  void updateSortOption(String option) {
    sortOption.value = option;
    filterProducts();
  }

  void filterProducts() {
    if (searchQuery.isEmpty) {
      filteredProducts.value = List.from(productList);
    } else {
      filteredProducts.value = productList
          .where((product) =>
      product.title?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
          .toList();
    }

    // Apply sorting
    switch (sortOption.value) {
      case 'price_low_high':
        filteredProducts.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case 'price_high_low':
        filteredProducts.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case 'rating':
        filteredProducts.sort((a, b) => (b.rating?.rate ?? 0).compareTo(a.rating?.rate ?? 0));
        break;
      default:
        break;
    }
  }

  Future<void> fetchProducts() async {
    inProgress.value = true;
    try {
      if (await networkService.isConnected()) {
        final response = await NetworkCaller().getRequest(AppUrls.product);

        if (response.isSuccess) {
          List<Product> products;
          if (response.responseData is String) {
            products = productFromJson(response.responseData);
          } else if (response.responseData is List) {
            products = (response.responseData as List)
                .map((json) => Product.fromJson(json))
                .toList();
          } else {
            throw Exception("Unexpected response format: ${response.responseData.runtimeType}");
          }

          productList.value = products;
          filterProducts();
          await _storeProductsInDb(products);
        }
      } else {
        await _loadProductsFromDb();
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching products: $e');
    } finally {
      inProgress.value = false;
    }
  }

  Future<void> _storeProductsInDb(List<Product> products) async {
    await databaseHelper.clearDatabase();
    for (var product in products) {
      await databaseHelper.insert(product);
    }
  }

  Future<void> _loadProductsFromDb() async {
    final products = await databaseHelper.getProducts();
    productList.value = products;
    filterProducts();
  }

  /// Load more products (pagination)
  Future<void> loadMoreProducts() async {
    if (currentPage.value >= 2) {
      hasMoreData.value = false;
      return;
    }

    inProgress.value = true;
    currentPage.value++;

    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<Product> moreProducts = productList.map((product) {
        return Product(
          id: product.id! + 100,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image: product.image,
          rating: product.rating,
        );
      }).toList();

      productList.addAll(moreProducts);
      filterProducts();

    } catch (e) {
      AppLoggerHelper.error('Error loading more products: $e');
    } finally {
      inProgress.value = false;
    }
  }
}
