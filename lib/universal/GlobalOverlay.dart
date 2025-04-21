import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalOverlay extends GetxController {
  var buttonIsClick = false.obs;
  var loading = false.obs;
  var remainingTime = 10.obs; // Track countdown

  Timer? _timer; // Store timer instance

  /// Toggle the button state
  toggleButton() {
    buttonIsClick.value = !buttonIsClick.value;
    buttonIsClick.refresh();
    if (buttonIsClick.value) startTimeout();
  }

  /// Reset the button state
  resetButton() {
    buttonIsClick.value = false;
    buttonIsClick.refresh();
    stopTimer();
  }

  /// Set loading state
  setLoading(bool load) {
    loading.value = load;
    if (load) startTimeout();
  }

  /// Reset loading state
  resetLoading() {
    loading.value = false;
    stopTimer();
  }

  /// Start a 10-second countdown timer
  void startTimeout() {
    remainingTime.value = 10; // Reset countdown
    _timer?.cancel(); // Cancel previous timer if running
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime.value--; // Decrease time
      print(" Overlay Time left: ${remainingTime.value} seconds"); // Debugging

      if (remainingTime.value <= 0) {
        buttonIsClick.value = false;
        loading.value = false;
        buttonIsClick.refresh();
        loading.refresh();
        timer.cancel(); // Stop timer
      }
    });
  }

  /// Stop timer manually
  void stopTimer() {
    _timer?.cancel();
    remainingTime.value = 0;
  }

  /// Getter for button click state
  bool get isButtonClicked => buttonIsClick.value;

  /// Getter for loading state
  bool get isLoading => loading.value;

  /// Overlay widget
  Widget overlay() {
    return Obx(() {
      print("Overlay state: ${buttonIsClick.value}, ${loading.value}");

      if (buttonIsClick.value || loading.value) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.grey.withOpacity(0.5),
              alignment: Alignment.center,
              height: MediaQuery.of(Get.context!).size.height,
              width: MediaQuery.of(Get.context!).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 10),
                  Text("Closing in ${remainingTime.value} seconds",
                      style: const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            )
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
