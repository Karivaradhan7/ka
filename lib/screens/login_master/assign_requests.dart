import 'package:flutter/material.dart';

class AssignRequestsPage extends StatefulWidget {
  @override
  _AssignRequestsPageState createState() => _AssignRequestsPageState();
}

class _AssignRequestsPageState extends State<AssignRequestsPage> {
  /// 🔹 Mock Data (Requests List)
  List<Map<String, dynamic>> requests = [
    {"id": "REQ-101", "location": "Downtown Area", "status": "Pending"},
    {"id": "REQ-102", "location": "North Street", "status": "Pending"},
    {"id": "REQ-103", "location": "Green Park", "status": "Assigned"},
    {"id": "REQ-104", "location": "Industrial Zone", "status": "Completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light Background
      appBar: AppBar(
        title: Text(
          "Assign Requests",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            var request = requests[index];

            return AnimatedContainer(
              duration: Duration(milliseconds: 300), // Smooth UI Animation
              curve: Curves.easeInOut,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade100,
                    child: Icon(Icons.assignment, color: Colors.deepPurple, size: 28),
                    radius: 25,
                  ),
                  title: Text(
                    request["id"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "📍 ${request["location"]}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  trailing: _statusBadge(request["status"]),
                  onTap: () {
                    _assignDriverDialog(request);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 🔹 Status Badge with Icon
  Widget _statusBadge(String status) {
    Color badgeColor;
    IconData iconData;
    switch (status) {
      case "Pending":
        badgeColor = Colors.orange;
        iconData = Icons.hourglass_empty;
        break;
      case "Assigned":
        badgeColor = Colors.blue;
        iconData = Icons.directions_bus;
        break;
      case "Completed":
        badgeColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      default:
        badgeColor = Colors.grey;
        iconData = Icons.help_outline;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 18, color: badgeColor),
          SizedBox(width: 5),
          Text(status, style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// 🔹 Assign Driver Dialog (Enhanced)
  void _assignDriverDialog(Map<String, dynamic> request) {
    String? selectedDriver;
    List<String> drivers = ["Driver A", "Driver B", "Driver C"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Assign Driver to ${request["id"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "📍 Location: ${request["location"]}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                ),
                hint: Text("Select Driver"),
                items: drivers.map((driver) {
                  return DropdownMenuItem(value: driver, child: Text(driver));
                }).toList(),
                onChanged: (val) {
                  selectedDriver = val;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              onPressed: () {
                if (selectedDriver != null) {
                  setState(() {
                    request["status"] = "Assigned";
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Assign"),
            ),
          ],
        );
      },
    );
  }
}
