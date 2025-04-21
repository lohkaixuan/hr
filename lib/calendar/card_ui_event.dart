import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hr/api/api_model.dart';
import 'package:intl/intl.dart';

class CardEvent extends StatelessWidget {
  final dynamic event; // Use dynamic to handle both Event and Events models

  const CardEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, // Slight shadow for UI
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16), // Inner padding
      margin: const EdgeInsets.only(bottom: 10), // Spacing between cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Title: ${_getEventTitle(event)}", // Handle title for both models
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          AutoSizeText(
            "Location: ${_getEventLocation(event)}", // Handle location for both models
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          AutoSizeText(
            "Apply by: ${_getApplyBy(event)}", // Handle apply by for both models
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          AutoSizeText(
            "${_getEventDate(event)}", // Handle date for both models
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          
          AutoSizeText(
            "${_getEventTime(event)}", // Handle time for both models
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "Status: ${_getEventStatus(event)}", // Handle status for both models
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),
                maxLines: 1,
              ),
              const SizedBox(width: 5),
              Icon(Icons.info, color: _getStatusColor(_getEventStatus(event))),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to check if event is of type Event or Events
  bool isEvent(dynamic event) => event is Event;
  bool isEvents(dynamic event) => event is Events;

  String _getEventTitle(dynamic event) {
    if (isEvent(event)) {
      return event.event_name.isNotEmpty ? event.event_name : "Untitled Event";
    } else if (isEvents(event)) {
      return event.event_name.isNotEmpty ? event.event_name : "Untitled Event";
    }
    return "Untitled Event";
  }

  String _getEventDate(dynamic event) {
    if (isEvent(event)) {
      return event.date.isNotEmpty ? "Date : ${formatDate(event.date)}" : "No date provided";
    } else if (isEvents(event)) {
      return event.start_date.isNotEmpty ? "Start Date : ${formatDate(event.start_date)}"  : "No date provided";
    }
    return "No date provided";
  }

  String _getEventLocation(dynamic event) {
    if (isEvent(event)) {
      return event.location.isNotEmpty ? event.location : "No location provided";
    } else if (isEvents(event)) {
      return event.location.isNotEmpty ? event.location : "No location provided";
    }
    return "No location provided";
  }

  String _getApplyBy(dynamic event) {
    if (isEvent(event)) {
      return event.applyBy.isNotEmpty ? event.applyBy : "No apply by ";
    } else if (isEvents(event)) {
      return event.applyBy.isNotEmpty ? event.applyBy : "No apply by ";
    }
    return "No apply by ";
  }

  String _getEventTime(dynamic event) {
    if (isEvent(event)) {
      return event.time.isNotEmpty ? "Time : ${formatTime(event.time)}"  : "No time provided";
    } else if (isEvents(event)) {
      return event.end_date.isNotEmpty ? "End date: ${formatDate(event.end_date)}" : "No time provided";
    }
    return "No time provided";
  }

  String _getEventStatus(dynamic event) {
    if (isEvent(event)) {
      return event.status.isNotEmpty ? event.status : "No status available";
    } else if (isEvents(event)) {
      return event.status.isNotEmpty ? event.status : "No status available";
    }
    return "No status available";
  }

  String formatDate(String date) {
    try {
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date); // Parse date format (YYYY-MM-DD)
      return DateFormat("MMM dd, yyyy").format(parsedDate); // Convert to readable format (e.g., "Jan 01, 2025")
    } catch (e) {
      return "Invalid date"; // Fallback in case of error
    }
  }

  String formatTime(String time) {
    try {
      DateTime parsedTime = DateFormat("HH:mm:ss").parse(time); // Parse 24-hour format
      return DateFormat("h:mm a").format(parsedTime); // Convert to 12-hour format
    } catch (e) {
      return "Invalid time"; // Fallback in case of error
    }
  }

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
