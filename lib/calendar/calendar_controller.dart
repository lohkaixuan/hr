import 'package:get/get.dart';
import 'package:hr/api/api_model.dart';
import 'package:hr/api/apis.dart';
import 'package:hr/api/dio.dart';
import 'package:hr/auth/auth_controller.dart';
import 'package:hr/storage/storage.dart';
import 'package:hr/universal/GlobalOverlay.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  final DioClient dioClient = DioClient();
  final GlobalOverlay _global = Get.find();

  var isLoading = false.obs;
  // var eventsList = <Events>[].obs;
  var eventList = <Event>[].obs;


@override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() async {  
    print(" api Fetching events..."); // 👈 Add this

    try {
      _global.toggleButton();
      // EventsResponse eventsresponse = await ApiService(dioClient).getEvents();
      EventResponse eventresponse = await ApiService(dioClient).getEvent();
      print("Event api: ${eventresponse.eventList[0].event_name}");

      // eventsList.assignAll(eventsresponse.eventsList);
      eventList.assignAll(eventresponse.eventList);
    } catch (e) {
      print("Failed to fetch events api: $e");
      _global.resetButton();

    } 
  }
}
