import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'create_request.dart';
import 'request_history.dart';
import 'notifications_screen.dart';
import 'trip_details_screen.dart'; // Import Trip Details Screen
import 'settings_screen.dart'; // Import Settings Screen

class FacilityOwnerDashboard extends StatefulWidget {
  @override
  _FacilityOwnerDashboardState createState() => _FacilityOwnerDashboardState();
}

class _FacilityOwnerDashboardState extends State<FacilityOwnerDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildTitleSection(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    _buildProfileSection(),
                    SizedBox(height: 20),
                    _buildPieChart(),
                    SizedBox(height: 20),
                    _buildDashboardCards(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + _fabController.value * 0.1,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRequestScreen()));
              },
              backgroundColor: Colors.green[700],
              elevation: 10,
              child: Icon(Icons.add, size: 30, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  /// **Title Section**
  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 40), // Spacer for center alignment
          Text(
            "Facility Owner Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }

  /// **Profile Section**
  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green.withOpacity(0.2), Colors.white]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.png'),
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 6),
              Text("ID: FO12345", style: TextStyle(fontSize: 16, color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }

  /// **Pie Chart**
  Widget _buildPieChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text("Waste Distribution", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 50,
                    sections: [
                      _pieChartSection(40, Colors.blue.shade600, "Solid"),
                      _pieChartSection(30, Colors.orange.shade600, "Liquid"),
                      _pieChartSection(30, Colors.green.shade600, "Recyclables"),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "Total\n100%",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _legendIndicator(Colors.blue.shade600, "Solid Waste"),
              _legendIndicator(Colors.orange.shade600, "Liquid Waste"),
              _legendIndicator(Colors.green.shade600, "Recyclables"),
            ],
          ),
        ],
      ),
    );
  }

  PieChartSectionData _pieChartSection(double value, Color color, String title) {
    return PieChartSectionData(
      value: value,
      color: color,
      title: "$value%\n$title",
      radius: 75,
      titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _legendIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// **Dashboard Cards**
  Widget _buildDashboardCards() {
    return CarouselSlider(
      options: CarouselOptions(height: 160, enlargeCenterPage: true, autoPlay: true, viewportFraction: 0.8),
      items: [
        _dashboardCard("Create Request", Icons.add, Colors.blue.shade400, CreateRequestScreen()),
        _dashboardCard("Request History", Icons.history, Colors.green.shade400, RequestHistoryScreen()),
        _dashboardCard("Notifications", Icons.notifications, Colors.orange.shade400, NotificationsScreen()),
        _dashboardCard("Trip Details", Icons.directions_bus, Colors.purple.shade400, TripDetailsScreen()), // Added Trip Details Card
      ],
    );
  }

  Widget _dashboardCard(String title, IconData icon, Color color, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [color.withOpacity(0.9), color.withOpacity(0.5)]),
            boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 12)],
          ),
          child: Row(
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(width: 16),
              Expanded(
                child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
