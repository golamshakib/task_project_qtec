import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_helper.dart'; // Import the local storage service

class NetworkService {
  // To notify connectivity changes
  final RxBool isConnected = true.obs;

  // Monitor the connectivity status and notify
  void monitorConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      // Check if there is internet connection
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
        // Show snackbar for no internet connection
        Get.snackbar(
          'No Internet',
          'Please check your internet connection.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });
  }

  // Method to check if the device is connected to the internet
  Future<bool> isConnectedToInternet() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
