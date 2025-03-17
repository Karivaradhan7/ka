import 'package:flutter/material.dart';
import 'assigned_trips.dart';
import 'trip_history.dart';
import 'notifications.dart';
import 'earnings_summary.dart';
import 'support_help.dart';
import 'fuel_distance_tracker.dart';

class DriverDashboard extends StatelessWidget {
  const DriverDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Driver Dashboard",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: dashboardItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1, // Prevents overflow
          ),
          itemBuilder: (context, index) {
            final item = dashboardItems[index];
            return _buildTile(context, item);
          },
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, DashboardItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => item.page));
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [item.color.withOpacity(0.8), item.color.withOpacity(1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 50, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Item Model
class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  DashboardItem({required this.title, required this.icon, required this.color, required this.page});
}

// List of Dashboard Items
final List<DashboardItem> dashboardItems = [
  DashboardItem(title: "Assigned Trips", icon: Icons.directions_car, color: Colors.blue, page: AssignedTripsPage()),
  DashboardItem(title: "Earnings Summary", icon: Icons.attach_money, color: Colors.green, page: EarningsSummaryPage()),
  DashboardItem(title: "Support & Help", icon: Icons.support_agent, color: Colors.red, page: SupportHelpPage()),
  DashboardItem(title: "Fuel & Distance Tracker", icon: Icons.local_gas_station, color: Colors.brown, page: FuelDistanceTrackerPage()),
  DashboardItem(title: "Trip History", icon: Icons.history, color: Colors.teal, page: TripHistoryPage()),
  DashboardItem(title: "Notifications", icon: Icons.notifications, color: Colors.indigo, page: NotificationsScreen()),
];
