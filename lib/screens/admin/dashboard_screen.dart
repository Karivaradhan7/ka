import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700], // Consistent green theme
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Overview"),

              /// ✅ **Wrap GridView inside Container with dynamic height**
              Container(
                padding: EdgeInsets.only(bottom: 10), // Prevents bottom overflow
                child: _overviewGrid([
                  _overviewTile("Total Users", "150", Icons.people, Colors.blue),
                  _overviewTile("Waste Collected", "1200 kg", Icons.recycling, Colors.green),
                  _overviewTile("Total Cost", "\$5,000", Icons.monetization_on, Colors.orange),
                  _overviewTile("Pending Requests", "25", Icons.hourglass_empty, Colors.red),
                ]),
              ),

              SizedBox(height: 20),

              _sectionTitle("Performance Metrics"),

              _progressTile("Drivers Under Work", 75, Colors.blue),
              _progressTile("Facility Owners Active", 60, Colors.green),
              _progressTile("Requests Completed", 90, Colors.orange),

              SizedBox(height: 20),

              _sectionTitle("Insights"),

              _insightsCard("Service Completion", "Completed: 120, Pending: 25", Icons.task_alt, Colors.blue),
              _insightsCard("Cost Analysis", "Total Revenue: \$5,000", Icons.attach_money, Colors.green),
              _insightsCard("Request Status", "Collected: 80%, Not Collected: 20%", Icons.bar_chart, Colors.orange),
            ],
          ),
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

  Widget _overviewGrid(List<Widget> tiles) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0, // ✅ More height for better text fitting
      ),
      itemCount: tiles.length,
      itemBuilder: (context, index) => tiles[index],
    );
  }




  Widget _overviewTile(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(minHeight: 150), // ✅ More space for text
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color), // ✅ Large, centered icon
            SizedBox(height: 8),

            /// ✅ **Ensure text fits inside the tile**
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // ✅ Prevents overflow
              ),
            ),

            SizedBox(height: 5),

            /// ✅ **Ensure value text is responsive**
            FittedBox(
              child: Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget _progressTile(String title, int percentage, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
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

  Widget _insightsCard(String title, String details, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 35),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(details, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
