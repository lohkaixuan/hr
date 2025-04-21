import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/api/api_model.dart';
import 'package:hr/calendar/calendar_controller.dart';
import 'package:hr/calendar/card_ui_event.dart';

class EventList extends StatelessWidget {
  EventList({super.key});

  final CalendarController _calendar = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        DateTime selectedDate = _calendar.selectedDay.value;
        String formattedDate = selectedDate.toLocal().toIso8601String().split("T")[0]; // Extract YYYY-MM-DD

        // ✅ Filter events that match the selected date (More than 1 event is possible)
        List<Event> selectedEvents = _calendar.events
            .where((event) => event.date.split("T")[0] == formattedDate)
            .toList();

        return selectedEvents.isEmpty
            ? const Center(child: Text("No events on this day"))
            : ListView.builder(
                shrinkWrap: true, // ✅ Prevents unnecessary space usage
                physics: const NeverScrollableScrollPhysics(), // ✅ Disables independent scrolling
                itemCount: selectedEvents.length,
                itemBuilder: (context, index) {
                  var event = selectedEvents[index];
                  return CardEvent(event: event); // ✅ Show each event
                },
              );
      }),
    );
  }
}
