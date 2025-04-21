import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/calendar/calendar_controller.dart';
import 'package:intl/intl.dart';

class AddEventForm {
  final CalendarController calendarController = Get.find();

  void showAddEventDialog() {
    final List<Map<String, dynamic>> fields = [
      {"label": "Event Title", "key": "title", "controller": TextEditingController()},
      {"label": "Description", "key": "description", "controller": TextEditingController()},
      {"label": "Participant", "key": "participant", "controller": TextEditingController()},
      {"label": "Is multiple days?", "key": "multi"},
      {"label": "Date", "key": "date", "controller": TextEditingController()},
      {"label": "Start Date", "key": "startDate", "controller": TextEditingController()},
      {"label": "End Date", "key": "endDate", "controller": TextEditingController()},
      {"label": "Time", "key": "time", "controller": TextEditingController()},
    ];

    final List<Map<String, dynamic>> leaveTypes = [
      {"name": "Annual Leave", "color": Colors.blue, "icon": Icons.calendar_today},
      {"name": "Medical Leave", "color": Colors.red, "icon": Icons.local_hospital},
      {"name": "Hospitalization Leave", "color": Colors.orange, "icon": Icons.hotel},
      {"name": "Marriage Leave", "color": Colors.pink, "icon": Icons.favorite},
      {"name": "Carry Forward Leave", "color": Colors.green, "icon": Icons.refresh},
      {"name": "Emergency Leave", "color": Colors.yellow, "icon": Icons.warning},
      {"name": "Compassionate Leave", "color": Colors.purple, "icon": Icons.sentiment_dissatisfied},
      {"name": "Public Holiday", "color": Colors.amber, "icon": Icons.flag},
    ];

    RxBool isMultiDay = false.obs;
    RxBool isCustomTitle = false.obs;

    Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      }
    }

    Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
      TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), // Force 24-hour format
            child: child!,
          );
        },
      );

      if (picked != null) {
        // Convert TimeOfDay to 24-hour format string
        final now = DateTime.now();
        final formattedTime = DateFormat.Hm().format(
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute,0),
        );

        controller.text = formattedTime; // Set formatted time
      }
    }

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Builder(builder: (context) {
              final textTheme = Theme.of(context).textTheme;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Add Event", style: textTheme.titleLarge),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: isCustomTitle.value
                                        ? TextField(
                                            controller: fields[0]["controller"],
                                            style: textTheme.bodyMedium,
                                            decoration: InputDecoration(
                                              labelText: "Event Title",
                                              labelStyle: textTheme.labelLarge,
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.clear),
                                                onPressed: () {
                                                  isCustomTitle.value = false;
                                                  fields[0]["controller"].clear();
                                                },
                                              ),
                                            ),
                                          )
                                        : DropdownButtonFormField<String>(
                                            value: fields[0]["controller"].text.isNotEmpty
                                                ? fields[0]["controller"].text
                                                : null,
                                            items: [
                                              ...leaveTypes.map<DropdownMenuItem<String>>(
                                                (option) => DropdownMenuItem<String>(
                                                  value: option["name"] as String,
                                                  child: Row(
                                                    children: [
                                                      Icon(option["icon"] as IconData,
                                                          color: option["color"] as Color),
                                                      const SizedBox(width: 8),
                                                      Text(option["name"] as String),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const DropdownMenuItem<String>(
                                                value: "Other",
                                                child: Text("Other"),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              if (value == "Other") {
                                                isCustomTitle.value = true;
                                                fields[0]["controller"].clear();
                                              } else {
                                                isCustomTitle.value = false;
                                                fields[0]["controller"].text = value!;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Leave Type",
                                              labelStyle: textTheme.labelLarge,
                                            ),
                                          ),
                                  ),
                                ],
                              )),
                          ...fields.sublist(1).map((field) {
                            if (field["key"] == "multi") {
                              return Obx(() => Row(
                                    children: [
                                      Expanded(
                                        child: Text(field['label'], style: textTheme.labelLarge),
                                      ),
                                      IconButton(
                                        icon: Icon(isMultiDay.value ? Icons.check_box : Icons.check_box_outline_blank),
                                        onPressed: () => isMultiDay.value = !isMultiDay.value,
                                      ),
                                    ],
                                  ));
                            }
                            if (field["key"] == "time") {
                              return Obx(() => isMultiDay.value
                                  ? const SizedBox.shrink()
                                  : _buildTextField(context, field["label"], field["controller"], Icons.access_time,
                                      () => _selectTime(Get.context!, field["controller"])));
                            }
                            if (field["key"] == "startDate" || field["key"] == "endDate") {
                              return Obx(() => isMultiDay.value
                                  ? _buildTextField(context, field["label"], field["controller"], Icons.calendar_today,
                                      () => _selectDate(Get.context!, field["controller"]))
                                  : const SizedBox.shrink());
                            } else if (field["key"] == "date") {
                              return Obx(() => !isMultiDay.value
                                  ? _buildTextField(context, field["label"], field["controller"], Icons.calendar_today,
                                      () => _selectDate(Get.context!, field["controller"]))
                                  : const SizedBox.shrink());
                            }
                            return field.containsKey("controller")
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TextField(
                                      controller: field["controller"],
                                      style: textTheme.bodyMedium,
                                      decoration: InputDecoration(
                                        labelText: field["label"],
                                        labelStyle: textTheme.labelLarge,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // calendarController.addEvent(
                          //   fields[0]["controller"].text,
                          //   fields[1]["controller"].text,
                          //   fields[2]["controller"].text,
                          //  // isMultiDay.value,
                          //   isMultiDay.value ? "" : fields[4]["controller"].text,
                          //   isMultiDay.value ? fields[5]["controller"].text : "",
                          //   isMultiDay.value ? fields[6]["controller"].text : "",
                          //   isMultiDay.value ? "" : fields[7]["controller"].text,
                          // );
                          Get.back();
                        },
                        child: const Text("Add Event"),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, TextEditingController controller, IconData icon, VoidCallback onTap) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: textTheme.labelLarge,
          suffixIcon: IconButton(
            icon: Icon(icon),
            onPressed: onTap,
          ),
        ),
        readOnly: true,
      ),
    );
  }
}
