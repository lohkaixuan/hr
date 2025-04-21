import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/calendar/calendar_controller.dart';
import 'package:hr/calendar/add_dialog.dart';
import 'package:hr/calendar/month_year.dart';
import 'package:intl/intl.dart';

class CalendarUI extends StatelessWidget {
  CalendarUI({super.key});

  final CalendarController calendarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        String monthName = DateFormat('MMMM').format(calendarController.selectedDay.value);
        DateTime selectedDay = calendarController.selectedDay.value;
        DateTime firstDayOfMonth = calendarController.firstDayOfMonth.value;
        int daysInMonth = calendarController.daysInMonth.value;
        int firstWeekday = firstDayOfMonth.weekday;
      
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔹 Month & Year Selector (Tap to Change)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      calendarController.selectedDay.value = DateTime(
                        selectedDay.year,
                        selectedDay.month - 1,
                        1,
                      );
                      calendarController.updateCalendar();
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      MonthYearPicker().showMonthYearPicker();
                    },
                    child: SizedBox(
                      width: 120, // Set max width
                      child: AutoSizeText(
                        "$monthName - ${selectedDay.year}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 1,     // Prevent multiple lines
                        minFontSize: 12, // Minimum size it can shrink to
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      calendarController.selectedDay.value = DateTime.now();
                      calendarController.updateCalendar();
                    },
                    child: SizedBox(
                      width: 40, // Adjust width as needed
                      child: AutoSizeText(
                        "Today",
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.w500,
                          color: Colors.purple.withOpacity(0.3), // Matches foreground color
                        ),
                        maxLines: 1,
                        minFontSize: 12, // Will shrink down to 12px if needed
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      calendarController.selectedDay.value = DateTime(
                        selectedDay.year,
                        selectedDay.month + 1,
                        1,
                      );
                      calendarController.updateCalendar();
                    },
                  ),
                ],
              ),
      
              /// 🔹 Days of the Week Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, // 7 days in a week
                    childAspectRatio: 1.9,
                  ),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue.withOpacity(.3),
                      alignment: Alignment.center,  // Center the text
                      child: AutoSizeText(
                        ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index],
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        maxLines: 1,  // Ensures text stays in one line
                        minFontSize: 8,  // Text will shrink to at least 8pt if needed
                      ),
                    );
                  },
                ),
              ),
      
              /// 🔹 Calendar Grid
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 7 days in a week
                  childAspectRatio: 1.9,
                  crossAxisSpacing: 0,
                  mainAxisSpacing:  0,
                  
                ),
                itemCount: daysInMonth + firstWeekday,
                itemBuilder: (context, index) {
                  if (index < firstWeekday) {
                    return Container(); // Empty space before the 1st day
                  }
                  int day = index - firstWeekday + 1;
                  return GestureDetector(
                    onTap: () {
                      calendarController.selectedDay.value = DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        day,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4), 
                      margin: const EdgeInsets.all(2), 
                      decoration: BoxDecoration(
                        color: selectedDay.day == day ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          "$day",
                          style: TextStyle(
                            color: selectedDay.day == day ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,  // Ensures text stays in one line
                          minFontSize: 12,  // Text will shrink to at least 8pt if needed
                        )
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 30, // Adjust width to make it smaller
                    height: 30, // Adjust height to make it smaller
                    child: FloatingActionButton(
                      onPressed: () {
                        AddEventForm().showAddEventDialog();
                      },
                      backgroundColor: Colors.purpleAccent, // Button color
                      child: Icon(Icons.add, color: Colors.white, size: 18), // Adjust icon size
                      tooltip: "Add Event",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
