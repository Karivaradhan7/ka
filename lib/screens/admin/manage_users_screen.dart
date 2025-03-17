import 'package:flutter/material.dart';
import 'user_details_screen.dart';

class ManageUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Users", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700], // Consistent theme
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("User Roles"),

            /// 🚀 **Enhanced User Category Tiles**
            _userCategoryTile(context, "Drivers", Icons.directions_car, Colors.blue, "drivers"),
            _userCategoryTile(context, "Facility Owners", Icons.store, Colors.green, "owners"),
            _userCategoryTile(context, "Login Masters", Icons.admin_panel_settings, Colors.orange, "masters"),

            SizedBox(height: 20),

            _sectionTitle("User Activity Overview"),

            /// 🚀 **Enhanced Progress Tiles**
            _progressTile("Drivers Under Work", 75, Colors.blue),
            _progressTile("Facility Owners Active", 60, Colors.green),
            _progressTile("Login Masters Verified", 90, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  /// ✅ **Enhanced User Category Tile**
  Widget _userCategoryTile(BuildContext context, String title, IconData icon, Color color, String type) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(userType: type)));
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              /// 🚀 **Circular Icon Container for a modern look**
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54), // 🔥 Adds a subtle navigation hint
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ **Enhanced Progress Tile**
  Widget _progressTile(String title, int percentage, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 8),

            /// 🚀 **Rounded Progress Bar**
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 12,
              ),
            ),

            SizedBox(height: 8),
            Text("$percentage% Completed", style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
