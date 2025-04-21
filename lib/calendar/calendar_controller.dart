import 'package:get/get.dart';
import 'package:hr/api/api_model.dart';
import 'package:hr/api/apis.dart';
import 'package:hr/api/dio.dart';
import 'package:hr/auth/auth_controller.dart';
import 'package:hr/storage/storage.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  final DioClient dioClient = DioClient();
  final AuthController _auth = Get.find();

  var selectedDay = DateTime.now().obs;
  var events = <Event>[].obs;
  var firstDayOfMonth = DateTime.now().obs;
  var daysInMonth = 0.obs;

  int? userId;

  @override
  void onInit() async {
    super.onInit();
    userId = await Storage().getUserId() ;
    
    print("userid api $userId");
    if (userId != null) {
      loadEvents();
    } else {
      Get.snackbar("Error", "Invalid User ID");
    }
  }

  void updateCalendar() {
    DateTime selected = selectedDay.value;
    firstDayOfMonth.value = DateTime(selected.year, selected.month, 1);
    daysInMonth.value = DateTime(selected.year, selected.month + 1, 0).day;
  }

  Future<void> loadEvents() async {
    if (userId == null) return;

    try {
      // var response = await ApiService(dioClient).getEvents(userId!);
      // events.assignAll(response.events);
    } catch (e) {
      Get.snackbar("Error", "Failed to load events: $e");
    }
  }

  Future<void> addEvent(
    String title,
    String description,
    String participant,
    String? singleDate,
    String? startDate,
    String? endDate,
    String? time,
  ) async {
    if (userId == null) return;
      // Print the incoming parameters
  
    try {
      if (singleDate != null && singleDate.isNotEmpty) {
        startDate = null;
        endDate = null;
      }
      DateTime parsedTime = DateFormat("HH:mm").parse(time!);  // Assuming input is in HH:mm format
      String formattedTime = DateFormat("HH:mm:ss").format(parsedTime);
      print('Adding event:');
      print('Title: $title');
      print('Description: $description');
      print('Participant: $participant');
      print('Single Date: $singleDate');
      print('Start Date: $startDate');
      print('End Date: $endDate');
            print('Time: $formattedTime');

      print('Time: $formattedTime  time format');
      // var response = await ApiService(dioClient).createEvent(
      //   title: title,
      //   description: description,
      //   participant: participant,
      //   singleDate: singleDate,
      //   startDate: startDate,
      //   endDate: endDate,
      //   time: formattedTime,
      // );

      // if (response.status == "success") {
      //   await loadEvents();
      //   Get.snackbar("Success", "Event added successfully!");
      // } else {
      //   Get.snackbar("Error", "Failed to add event: ${response.message}");
      //   print("api error ${response.message}");
      // }
    } catch (e) {
      Get.snackbar("Unexpected Error", "Failed to add event: $e");
      print("api error $e");

    }
  }

  Future<void> updateEvent(
    String eventId,
    String title,
    String description,
    String time,
    String participant,
    String dateKey,
  ) async {
    if (userId == null) return;

    try {
      // var response = await ApiService(dioClient).editEvent(
      //   eventId: eventId,
      //   title: title,
      //   description: description,
      //   time: time,
      //   participant: participant,
      //   dateKey: dateKey,
      // );

      // if (response.status == "success") {
      //   await loadEvents();
      //   Get.snackbar("Success", "Event updated successfully!");
      // } else {
      //   Get.snackbar("Error", "Failed to update event: ${response.message}");
      // }
    } catch (e) {
      Get.snackbar("Error", "Failed to update event: $e");
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      // final response = await ApiService(dioClient).removeEvent(eventId);
      // if (response.status == "success") {
      //   await loadEvents();
      //   Get.snackbar("Success", "Event deleted successfully!");
      // } else {
      //   Get.snackbar("Error", "Failed to delete event: ${response.message}");
      // }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete event: $e");
    }
  }

  Future<void> updateEventStatus(String eventId, String status) async {
    try {
      // final response = await ApiService(dioClient).updateEventStatus(eventId, status);
      // if (response["status"] == "success") {
      //   await loadEvents();
      //   Get.snackbar("Success", "Event status updated successfully!");
      // } else {
      //   Get.snackbar("Error", "Failed to update event status: ${response["message"]}");
      // }
    } catch (e) {
      Get.snackbar("Error", "Failed to update event status: $e");
    }
  }

  Future<void> autoUpdatePastEvents() async {
    try {
      // final response = await ApiService(dioClient).autoUpdatePastEvents();
      // if (response["status"] == "success") {
      //   await loadEvents();
      //   Get.snackbar("Success", "Past events updated successfully!");
      // } else {
      //   Get.snackbar("Error", "Failed to auto-update past events: ${response["message"]}");
      // }
    } catch (e) {
      Get.snackbar("Error", "Failed to auto-update past events: $e");
    }
  }
}

