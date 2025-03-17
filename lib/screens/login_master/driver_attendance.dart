import 'package:flutter/material.dart';

class DriverAttendancePage extends StatefulWidget {
  @override
  _DriverAttendancePageState createState() => _DriverAttendancePageState();
}

class _DriverAttendancePageState extends State<DriverAttendancePage> {
  /// 🔹 Mock Attendance Data
  List<Map<String, dynamic>> attendance = [
    {"name": "John Doe", "checkedIn": true, "time": "08:30 AM"},
    {"name": "Alex Smith", "checkedIn": false, "time": "Not Checked In"},
    {"name": "Michael Lee", "checkedIn": true, "time": "09:15 AM"},
    {"name": "Sarah Johnson", "checkedIn": false, "time": "Not Checked In"},
  ];

  /// 🔹 Toggle Attendance Status
  void _toggleCheckIn(int index) {
    setState(() {
      bool isCheckedIn = !attendance[index]["checkedIn"];
      attendance[index]["checkedIn"] = isCheckedIn;
      attendance[index]["time"] = isCheckedIn ? _getCurrentTime() : "Not Checked In";
    });
  }

  /// 🔹 Get Current Time
  String _getCurrentTime() {
    final now = DateTime.now();
    int hour = now.hour > 12 ? now.hour - 12 : now.hour;
    String period = now.hour >= 12 ? 'PM' : 'AM';
    return "${hour}:${now.minute.toString().padLeft(2, '0')} $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light Gray Background
      appBar: AppBar(
        title: Text(
          "Driver Attendance",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[700], // Darker Header
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: attendance.length,
          itemBuilder: (context, index) {
            return _buildAttendanceCard(index);
          },
        ),
      ),
    );
  }

  /// 🔹 **Build Enhanced Attendance Card**
  Widget _buildAttendanceCard(int index) {
    bool isCheckedIn = attendance[index]["checkedIn"];

    return AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth UI Animation
      curve: Curves.easeInOut,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: isCheckedIn ? Colors.green[50] : Colors.red[50],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🔹 **Driver Name & Check-in Time**
              Expanded(
                child: Row(
                  children: [
                    /// 🔹 Attendance Icon
                    Icon(
                      isCheckedIn ? Icons.check_circle : Icons.cancel,
                      color: isCheckedIn ? Colors.green : Colors.red,
                      size: 30,
                    ),
                    SizedBox(width: 12),

                    /// 🔹 Name & Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attendance[index]["name"],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 18, color: Colors.blueGrey),
                            SizedBox(width: 6),
                            Text(
                              attendance[index]["time"],
                              style: TextStyle(fontSize: 15, color: Colors.blueGrey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// 🔹 **Toggle Switch**
              Transform.scale(
                scale: 1.1, // Slightly bigger switch
                child: Switch(
                  value: isCheckedIn,
                  onChanged: (val) => _toggleCheckIn(index),
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
