import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignedTripsPage extends StatefulWidget {
  @override
  _AssignedTripsPageState createState() => _AssignedTripsPageState();
}

class _AssignedTripsPageState extends State<AssignedTripsPage> {
  List<Map<String, dynamic>> trips = [
    {
      "facilityOwner": "John Doe",
      "phone": "9876543210",
      "location": "Greenwood Apartments",
      "wasteDetails": "Solid Waste: 50kg, Liquid Waste: 20L",
      "requestDate": "10 Mar 2025",
      "status": "Pending",
      "latitude": 12.9716,
      "longitude": 77.5946,
    },
    {
      "facilityOwner": "Emily Smith",
      "phone": "8765432109",
      "location": "Sunrise Hotel",
      "wasteDetails": "Solid Waste: 30kg, Liquid Waste: 15L",
      "requestDate": "12 Mar 2025",
      "status": "Pending",
      "latitude": 12.2958,
      "longitude": 76.6394,
    },
  ];

  // 📞 Function to launch the dialer
  void _makeCall(String phone) async {
    final Uri url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch dialer");
    }
  }

  // 📩 Function to launch the messaging app
  void _sendMessage(String phone) async {
    final Uri url = Uri.parse("sms:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch messages");
    }
  }

  // 🔍 Function to open Google Lens (QR Scanner)
  void _scanQR() async {
    final Uri url = Uri.parse("googleapp://lens");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not open Google Lens");
    }
  }

  // 📍 Function to open Google Maps with navigation
  void _openMaps(double latitude, double longitude) async {
    final Uri url = Uri.parse("google.navigation:q=$latitude,$longitude");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not open Google Maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Trips", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            return _buildTripTile(trip);
          },
        ),
      ),
    );
  }

  // 📌 Improved Trip tile UI with ExpansionTile
  Widget _buildTripTile(Map<String, dynamic> trip) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          trip['location'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconText(Icons.person, "Owner: ${trip['facilityOwner']}", Colors.orange),
            _iconText(Icons.delete, "Waste: ${trip['wasteDetails']}", Colors.red),
            _iconText(Icons.calendar_today, "Date: ${trip['requestDate']}", Colors.blue),
          ],
        ),
        children: [_buildActionButtons(trip)],
      ),
    );
  }

  // 📌 Compact Action Buttons (Call, Message, Scan, Maps)
  Widget _buildActionButtons(Map<String, dynamic> trip) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCompactButton(Icons.call, "Call", () => _makeCall(trip['phone'])),
          _buildCompactButton(Icons.message, "Message", () => _sendMessage(trip['phone'])),
          _buildCompactButton(Icons.qr_code_scanner, "Scan", _scanQR),
          _buildCompactButton(Icons.map, "Maps", () => _openMaps(trip['latitude'], trip['longitude'])),
        ],
      ),
    );
  }

  // 📌 Reusable Compact Icon Button with Hover Effect
  Widget _buildCompactButton(IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      splashColor: Colors.orange.withOpacity(0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: Colors.orange[800]),
          ),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // 📌 Reusable Row with Icon and Text
  Widget _iconText(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 5),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[800]), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
