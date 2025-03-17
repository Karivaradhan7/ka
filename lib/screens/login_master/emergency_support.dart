import 'package:flutter/material.dart';

class EmergencySupportPage extends StatelessWidget {
  void _callSupport() {
    print("📞 Calling emergency support...");
  }

  void _sendMessage() {
    print("📩 Sending emergency message...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50], // Light Red Background
      appBar: AppBar(
        title: Text(
          "Emergency Support",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 **Emergency Icon & Title**
            Icon(Icons.warning, color: Colors.redAccent, size: 80),
            SizedBox(height: 10),
            Text(
              "Need Immediate Assistance?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 30),

            /// 🔹 **Call Support Button**
            _buildEmergencyButton(
              icon: Icons.call,
              label: "Call Support",
              color: Colors.red,
              onPressed: _callSupport,
            ),

            SizedBox(height: 20),

            /// 🔹 **Send Message Button**
            _buildEmergencyButton(
              icon: Icons.message,
              label: "Send Emergency Message",
              color: Colors.orange,
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Reusable Emergency Button Widget**
  Widget _buildEmergencyButton({required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity, // Full width button
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5, // Slight shadow
        ),
      ),
    );
  }
}
