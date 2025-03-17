import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetailsScreen extends StatefulWidget {
  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  List<Map<String, String>> upcomingTrips = [
    {"driver": "Rahul Sharma", "vehicle": "MH 14 XY 1234", "phone": "+91 9876543210"},
    {"driver": "Amit Patel", "vehicle": "KA 03 AB 5678", "phone": "+91 8765432109"},
  ];

  List<Map<String, String>> completedTrips = [
    {"driver": "Suresh Kumar", "vehicle": "DL 09 PQ 4321", "phone": "+91 7654321098"},
    {"driver": "Mohammed Iqbal", "vehicle": "TN 10 LM 8765", "phone": "+91 6543210987"},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[700],
          child: Icon(Icons.call, color: Colors.white, size: 28),
          onPressed: () {
            _showCallMessageMenu(context, "+91 9876543210");
          },
        ),
        body: Column(
          children: [
            // Custom Header with Title and Back Button (Similar to RequestHistory)
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[800]!, Colors.green[500]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Trip Details",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Custom Tab Bar
            Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: TabBar(
                labelColor: Colors.green[700],
                indicatorColor: Colors.green[700],
                tabs: [
                  Tab(
                    icon: Icon(Icons.pending_actions, color: Colors.orange),
                    text: "Upcoming (${upcomingTrips.length})",
                  ),
                  Tab(
                    icon: Icon(Icons.check_circle, color: Colors.green),
                    text: "Completed (${completedTrips.length})",
                  ),
                ],
              ),
            ),

            // Trip List Views
            Expanded(
              child: TabBarView(
                children: [
                  _buildTripList(upcomingTrips, "Upcoming"),
                  _buildTripList(completedTrips, "Completed"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripList(List<Map<String, String>> trips, String status) {
    return trips.isEmpty
        ? Center(
      child: Text(
        "No $status Trips Available",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    )
        : ListView.builder(
      itemCount: trips.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showCallMessageMenu(context, trips[index]["phone"]!),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: status == "Upcoming"
                    ? [Colors.orange[100]!, Colors.orange[300]!]
                    : [Colors.green[100]!, Colors.green[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.directions_bus,
                  color: status == "Upcoming" ? Colors.orange : Colors.green,
                ),
              ),
              title: Text(
                trips[index]["driver"]!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle: ${trips[index]["vehicle"]}"),
                  Text("Phone: ${trips[index]["phone"]}"),
                ],
              ),
              trailing: Icon(
                status == "Upcoming" ? Icons.timer : Icons.check_circle,
                color: status == "Upcoming" ? Colors.orange : Colors.green,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCallMessageMenu(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text("Contact Driver", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Would you like to call or message the driver?"),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                _launchCaller(phoneNumber);
                Navigator.pop(context);
              },
              icon: Icon(Icons.call, color: Colors.white),
              label: Text("Call", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                _launchMessage(phoneNumber);
                Navigator.pop(context);
              },
              icon: Icon(Icons.message, color: Colors.white),
              label: Text("Message", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _launchCaller(String phoneNumber) async {
    String url = "tel:$phoneNumber";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _launchMessage(String phoneNumber) async {
    String url = "sms:$phoneNumber";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
