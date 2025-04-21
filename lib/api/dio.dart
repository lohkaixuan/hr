import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hr/storage/storage.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://mobile-test-b4a52.uc.r.appspot.com".trim(), // ✅ Change to your API URL
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            // headers: {
            //   'Content-Type': 'application/json',
            //   'Accept': 'application/json',
            // },
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await Storage().getAuthToken(); // ✅ Load stored token
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          // 🔹 Redirect to login if unauthorized
          Get.offAllNamed('/login');
        }
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
