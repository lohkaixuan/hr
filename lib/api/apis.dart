import 'package:dio/dio.dart';
import 'package:hr/api/api_model.dart';
import 'package:hr/api/dio.dart';
import 'package:hr/storage/storage.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() {
    return 'ApiException: $statusCode - $message';
  }
}

class ApiService {
  final DioClient _dioClient;
  String? _token;

  ApiService(this._dioClient);

  /// 🔹 Initialize the token asynchronously
  Future<void> initialize() async {
    _token = await Storage().getAuthToken();
  }

  /// 🔹 Authentication APIs
  Future<LoginResponse> login(String email, String password) async {
    try {
      var response = await _dioClient.dio.post('/login',
        data: {"email": email, "password": password},
      );
      print("login api $response");
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message'] ?? 'Something went wrong');
    }
  }

  // Future<RegisterResponse> register(email, password, name, phone, role) async {
  //   try {
  //     var response = await _dioClient.dio.post("/auth/register", 
  //       data: {"email": email, "password": password, "name": name, "phone": phone, "role": role},
  //     );
  //     print("register api $response");
  //     return RegisterResponse.fromJson(response.data);
  //   } on DioException catch (e) {
  //     throw ApiException(e.response?.statusCode, e.response?.data['message'] ?? 'Something went wrong');
  //   }
  // }


}
