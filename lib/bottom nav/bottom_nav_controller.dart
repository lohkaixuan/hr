import 'package:get/get.dart';

// Controller for handling navigation
class BottomNavController extends GetxController {
  var selectedIndex = 0.obs; // Observable for state management

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
  void homepage() {
    selectedIndex.value = 0;
  }
}

