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

  // Future<EventsResponse> getEvents() async {
  //       print("events api");   

  //   try {
  //     var response = await _dioClient.dio.get('/events/get',
  //       data: {},
  //     );
  //     print("event api Response: $response");

  //   // Print the type and value of the 'event_id' field of the first event in the response
  //   print("event_id type: ${response.data['data'][0]['event_id'].runtimeType}");
  //   print("event_id value: ${response.data['data'][0]['event_id']}");
  //     return EventsResponse.fromJson(response.data);
  //   } on DioException catch (e) {
  //     throw ApiException(e.response?.statusCode, e.response?.data['message'] ?? 'Something went wrong');
  //   }
  // }
  
  Future<EventResponse> getEvent() async {
    print("Fetching events...");

    try {
      // Make the GET request to the API
      var response = await _dioClient.dio.get('/event/get',);
      print("Response: ${response.data}");
      print("Response runtimeType: ${response.data.runtimeType}");

      // Decode the response data into the EventResponse model
      return EventResponse.fromJson(response.data);
    } on DioException catch (e) {
      // Handle any errors that occur during the request
      throw ApiException(
          e.response?.statusCode, e.response?.data['message'] ?? 'Something went wrong');
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
