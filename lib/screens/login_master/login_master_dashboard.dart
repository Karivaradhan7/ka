import 'package:flutter/material.dart';
import 'manage_drivers.dart';
import 'manage_vehicles.dart';
import 'driver_attendance.dart';
import 'performance_reports.dart';
import 'emergency_support.dart';
import 'assign_requests.dart';
import 'notifications.dart';
import 'waste_collection_summary.dart';

class LoginMasterDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Login Master Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 **Manage Drivers Tile**
            _buildLargeCard(
              context,
              "Manage Drivers",
              Icons.supervisor_account,
              Colors.blue,
              ManageDriversPage(),
            ),

            SizedBox(height: 20),

            /// 🔹 **Dynamic Grid Tiles**
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 600 ? 2 : 3, // Responsive Grid
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _tiles.length,
              itemBuilder: (context, index) {
                return _buildGridTile(
                  context,
                  _tiles[index]["title"],
                  _tiles[index]["icon"],
                  _tiles[index]["color"],
                  _tiles[index]["page"],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// **Large Card for Manage Drivers**
  Widget _buildLargeCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// **Icon with Background**
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: Colors.white),
              ),

              SizedBox(width: 15),

              /// **Text**
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// **Grid Tile Widget**
  Widget _buildGridTile(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// **Circular Icon Background**
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 45, color: color),
              ),

              SizedBox(height: 10),

              /// **Title**
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Grid Tile Data**
  final List<Map<String, dynamic>> _tiles = [
    {"title": "Assign Requests", "icon": Icons.assignment, "color": Colors.orange, "page": AssignRequestsPage()},
    {"title": "Notifications", "icon": Icons.notifications, "color": Colors.red, "page": NotificationsPage()},
    {"title": "Manage Vehicles", "icon": Icons.local_shipping, "color": Colors.teal, "page": ManageVehiclesPage()},
    {"title": "Attendance", "icon": Icons.calendar_today, "color": Colors.blueGrey, "page": DriverAttendancePage()},
    {"title": "Performance Reports", "icon": Icons.pie_chart, "color": Colors.green, "page": PerformanceSummaryPage()}, {"title": "Emergency Support", "icon": Icons.emergency, "color": Colors.redAccent, "page": EmergencySupportPage()},
  ];
}
