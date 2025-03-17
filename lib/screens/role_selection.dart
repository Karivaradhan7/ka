import 'package:flutter/material.dart';
import 'package:waste_management/screens/facility_owner/facility_owner_dashboard.dart';
import 'package:waste_management/screens/admin/admin_dashboard.dart';
import 'package:waste_management/screens/driver/driver_dashboard.dart';
import 'package:waste_management/screens/login_master/login_master_dashboard.dart';

class RoleSelectionScreen extends StatefulWidget {
  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  int? hoveredIndex;

  Widget _buildRoleTile(String title, IconData icon, Color color, Widget destination, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: hoveredIndex == index ? color.withOpacity(0.7) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: hoveredIndex == index ? Colors.white : color),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: hoveredIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Role"), backgroundColor: Colors.green),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildRoleTile("Facility Owner", Icons.business, Colors.blue, FacilityOwnerDashboard(), 0),
            _buildRoleTile("Admin", Icons.admin_panel_settings, Colors.red, AdminDashboard(), 1),
            _buildRoleTile("Driver", Icons.directions_car, Colors.orange, DriverDashboard(), 2),
            _buildRoleTile("Login Master", Icons.person, Colors.purple, LoginMasterDashboard(), 3),
          ],
        ),
      ),
    );
  }
}
