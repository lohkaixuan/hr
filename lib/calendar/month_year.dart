import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/calendar/calendar_controller.dart';

class MonthYearPicker {
  final CalendarController calendarController = Get.find();

  void showMonthYearPicker() {
    int selectedYear = calendarController.selectedDay.value.year;
    int selectedMonth = calendarController.selectedDay.value.month;

    Get.dialog(
      AlertDialog(
        title: const Text("Select Month & Year"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<int>(
              value: selectedYear,
              onChanged: (newYear) {
                if (newYear != null) {
                  selectedYear = newYear;
                }
              },
              items: List.generate(
                50,
                (index) => DropdownMenuItem(
                  value: 2000 + index,
                  child: Text("${2000 + index}"),
                ),
              ),
            ),
            DropdownButton<int>(
              value: selectedMonth,
              onChanged: (newMonth) {
                if (newMonth != null) {
                  selectedMonth = newMonth;
                }
              },
              items: List.generate(
                12,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text(
                    ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
                  ][index],style: TextStyle(
                    fontWeight: FontWeight.w400
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              calendarController.selectedDay.value =
                  DateTime(selectedYear, selectedMonth, 1);
              calendarController.updateCalendar();
              Get.back();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
