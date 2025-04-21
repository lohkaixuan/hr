import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/calendar/card_ui_event.dart';
import 'package:hr/universal/GlobalOverlay.dart';
import 'calendar_controller.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final CalendarController _calendar = Get.find();  
  final GlobalOverlay _global = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 242, 202, 255).withOpacity(.4),
            child: Obx(() {
              // Loading check

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section for eventList
                    if (_calendar.eventList.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("User Events", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _calendar.eventList.length,
                        itemBuilder: (context, index) {
                          final event = _calendar.eventList[index];
                          return CardEvent(event: event);
                        },
                      ),
                    ] else ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("No User Events Found"),
                      )
                    ],

                    //// Section for eventsList
                    // if (_calendar.eventsList.isNotEmpty) ...[
                    //   const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text("Admin Events", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    //   ),
                    //   ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemCount: _calendar.eventsList.length,
                    //     itemBuilder: (context, index) {
                    //       final event = _calendar.eventsList[index];
                    //       return CardEvent(event: event);
                    //     },
                    //   ),
                    // ] else ...[
                    //   const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text("No Admin Events Found"),
                    //   )
                    // ],
                  ],
                ),
              );
            }),
          ),
          _global.overlay()
        ],
      ),
    );
  }
}
