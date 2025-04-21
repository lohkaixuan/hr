import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hr/api/api_model.dart';
import 'package:intl/intl.dart';

class CardEvent extends StatelessWidget {
  final Event event; // ✅ Use the Event class properly

  const CardEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // ✅ Set background color
        borderRadius: BorderRadius.circular(20), // ✅ Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, // ✅ Adds slight shadow for better UI
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16), // ✅ Inner padding
      margin: const EdgeInsets.only(bottom: 10), // ✅ Spacing between cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Title: ${event.event_name.isNotEmpty ? event.event_name : "Untitled Event"}",
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5), // ✅ Spacing

          // AutoSizeText(
          //   "Description: ${event.description.isNotEmpty ? event.description : "No description available"}",
          //   style: const TextStyle(
          //     fontSize: 16, 
          //     fontWeight: FontWeight.w400,
          //     color: Colors.black
          //   ),
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis, // ✅ Adds "..." for long text
          // ),
          // const SizedBox(height: 5), // ✅ Spacing

          AutoSizeText(
            "Apply by: ${event.applyBy}", // ✅ Display user ID
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5), // ✅ Spacing

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "Time: ${event.time.isNotEmpty ? formatTime(event.time) : "No time provided"}",
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),
                maxLines: 1,
              ),
              const SizedBox(width: 5),

              Row(
                children: [
                  AutoSizeText(
                    "Status: ${event.status.isNotEmpty ? event.status : "No status available"}",
                    style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(width: 5), // ✅ Spacing
                  Icon(Icons.info, color: _getStatusColor(event.status)),
                ],
              ), // ✅ Status Icon
            ],
          ),
        ],
      ),
    );
  }
  String formatTime(String time) {
  try {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time); // Parse 24-hour format
    return DateFormat("h:mm a").format(parsedTime); // Convert to 12-hour format
  } catch (e) {
    return "Invalid time"; // Fallback in case of error
  }
}
  /// 📌 Function to get status color based on event status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
