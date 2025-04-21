import 'package:flutter/material.dart';
import 'package:hr/calendar/add_dialog.dart';

class Home extends StatelessWidget {
  final List<Map<String, dynamic>> leaveData = [
    {"name": "Annual Leave", "color": Colors.blue, "daysUsed": 10, "icon": Icons.calendar_today},
    {"name": "Medical Leave", "color": Colors.red, "daysUsed": 5, "icon": Icons.local_hospital},
    {"name": "Hospitalization Leave", "color": Colors.orange, "daysUsed": 2, "icon": Icons.hotel},
    {"name": "Marriage Leave", "color": Colors.pink, "daysUsed": 3, "icon": Icons.favorite},
    {"name": "Carry Forward Leave", "color": Colors.green, "daysUsed": 4, "icon": Icons.refresh},
    {"name": "Emergency Leave", "color": Colors.yellow, "daysUsed": 6, "icon": Icons.warning},
    {"name": "Compassionate Leave", "color": Colors.purple, "daysUsed": 1, "icon": Icons.sentiment_dissatisfied},
    {"name": "Public Holiday", "color": Colors.amber, "daysUsed": 8, "icon": Icons.flag},
  ];

  @override
  Widget build(BuildContext context) {
    double maxDays = leaveData.map((e) => (e["daysUsed"] as int).toDouble()).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(title: Text("Leave Usage")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: leaveData.map((leave) {
              double percentage = (leave["daysUsed"] as int).toDouble() / maxDays;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        
                         // // Space between icon and text
                          Text(
                            leave["name"],
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          //SizedBox(width: 8), 
                           Icon(leave["icon"], color: leave["color"], size: 25), // Icon beside text
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width * 0.5 * percentage,
                                decoration: BoxDecoration(
                                  color: leave["color"],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("${leave["daysUsed"]} days", style: TextStyle(fontSize: 14)),
                      ],
                    )
                    
                  ],
                ),
                
                );
            }).toList(),
          
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action here (e.g., open a new page, show a dialog)
          AddEventForm().showAddEventDialog();
        },
        backgroundColor: Colors.purple, // Set background color to purple
        child: Icon(Icons.add, color: Colors.white), // White "+" icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Position at bottom-right
    );
  }
}
