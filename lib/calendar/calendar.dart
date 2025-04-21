import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/calendar/calendar_ui.dart';
import 'package:hr/calendar/event_list.dart';
import 'calendar_controller.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final CalendarController calendarController = Get.find();

  @override
  void initState() {
    super.initState();
    calendarController.updateCalendar();
  }

  

  @override
  Widget build(BuildContext context) {
    print("login7 home");
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 242, 202, 255).withOpacity(.4), // Background color
        child: Column(
          children: [
            Expanded( // Ensures full height coverage
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CalendarUI(),
                    SizedBox(height: 16), // Space between widgets
                    EventList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
    
  }
}
