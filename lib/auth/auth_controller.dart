import 'package:get/get.dart';
import 'package:hr/api/api_model.dart';
import 'package:hr/api/apis.dart';
import 'package:hr/api/dio.dart';
import 'package:hr/storage/storage.dart';
import 'package:hr/universal/dialog.dart'; // Local storage for userId & token

class AuthController extends GetxController {
  final DioClient dioClient = DioClient();
  final ShowDialog _dialog = Get.find();
  User user = User(
    id: 1,
    name: "1",
    phone: "12345678",
    email: "testuser@example.com",
    role: "user", 
    date_joined: '',
    gender: '',
  );
  var role = "user".obs;
  var userId = 0.obs;
  var name  = "".obs;
  /// 📌 Login function (Calls API)
  Future<void> login(String email, String password) async {
    try {
      // Call API
      LoginResponse response = await ApiService(dioClient).login(email,password);
      String token = response.token;
      userId.value = response.user.id;
      name.value = response.user.name;
      role.value = response.user.role;
      await Storage().saveUserData(userId.value, name.value, token);
      Get.snackbar("Success", "Login successful! Your role is ${role.value}");
      print("ur  login role is ${role.value}");
      // Navigate based on role
      Get.offAllNamed("/home");
    } catch (e) {
      _dialog.handleError(e);
    }
  }

  /// 📌 Register function (Calls API)
  // Future<void> register(String email, String password, String name, String phone) async {
  //   try {
  //     RegisterResponse response = await ApiService(dioClient).register(email, password, name, phone, role);
  //     if (response.status == "success") {
  //       Get.snackbar("Success", "Account created successfully!");
  //       Get.toNamed("/login");
  //     } else {
  //       Get.snackbar("Error", "Registration failed. Try again.");
  //     }
  //   } catch (e) {
  //     _dialog.handleError(e);
  //   }
  // }

  
  Future<void> logout() async {
    try {
      await Storage().clearUserData();
      Get.offAndToNamed('/login');
    } catch (e) {
      _dialog.show_Dialog(Get.context!,"Thank you","Please support us");
    }
  }
}
