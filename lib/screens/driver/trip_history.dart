import 'package:flutter/material.dart';

class TripHistoryPage extends StatefulWidget {
  @override
  _TripHistoryPageState createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  bool showPendingTrips = false;
  bool showCompletedTrips = false;

  final List<Map<String, dynamic>> pendingTrips = [
    {
      "facilityOwner": "John Doe",
      "location": "Greenwood Apartments",
      "wasteDetails": "Solid Waste: 50kg, Liquid Waste: 20L",
      "requestDate": "10 Mar 2025",
      "status": "Pending"
    },
    {
      "facilityOwner": "Emily Smith",
      "location": "Sunrise Hotel",
      "wasteDetails": "Solid Waste: 30kg, Liquid Waste: 15L",
      "requestDate": "12 Mar 2025",
      "status": "Pending"
    },
  ];

  final List<Map<String, dynamic>> completedTrips = [
    {
      "facilityOwner": "Michael Johnson",
      "location": "City Mall",
      "wasteDetails": "Solid Waste: 70kg, Liquid Waste: 25L",
      "requestDate": "05 Mar 2025",
      "status": "Completed"
    },
    {
      "facilityOwner": "Sarah Williams",
      "location": "Hillview Plaza",
      "wasteDetails": "Solid Waste: 40kg, Liquid Waste: 10L",
      "requestDate": "07 Mar 2025",
      "status": "Completed"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Trip History"),
        backgroundColor: Colors.orange[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleTile("Pending Trips", showPendingTrips, () {
              setState(() {
                showPendingTrips = !showPendingTrips;
              });
            }),
            if (showPendingTrips) _buildTripList(pendingTrips),
            const SizedBox(height: 20),

            _buildToggleTile("Completed Trips", showCompletedTrips, () {
              setState(() {
                showCompletedTrips = !showCompletedTrips;
              });
            }),
            if (showCompletedTrips) _buildTripList(completedTrips),
            const SizedBox(height: 30),

            _buildMetricsSection(),
          ],
        ),
      ),
    );
  }

  // Toggle Tile for Pending & Completed Trips
  Widget _buildToggleTile(String title, bool isExpanded, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isExpanded ? 6 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isExpanded ? Colors.orange[200] : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Trip List
  Widget _buildTripList(List<Map<String, dynamic>> trips) {
    return Column(
      children: trips.map((trip) => _buildTripCard(trip)).toList(),
    );
  }

  // Trip Card with Hover Effect
  Widget _buildTripCard(Map<String, dynamic> trip) {
    return InkWell(
      onTap: () {
        _showTripDetails(trip);
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              "Trip to: ${trip['location']}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Facility Owner: ${trip['facilityOwner']}"),
                Text("Waste Details: ${trip['wasteDetails']}"),
                Text("Request Date: ${trip['requestDate']}"),
              ],
            ),
            trailing: Chip(
              label: Text(trip['status']),
              backgroundColor: trip['status'] == "Completed" ? Colors.green[300] : Colors.red[300],
            ),
          ),
        ),
      ),
    );
  }

  // Metrics Section
  Widget _buildMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Metrics & Statistics"),
        _buildMetricTile("Pending Trips vs Completed Trips", 70),
        _buildMetricTile("Waste Collection Efficiency", 85),
      ],
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // Metric Bar
  Widget _buildMetricTile(String title, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Stack(
          children: [
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            Container(
              height: 12,
              width: percentage * 2.5, // Adjusted for better UI
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Show Trip Details in a Dialog
  void _showTripDetails(Map<String, dynamic> trip) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Trip to ${trip['location']}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Facility Owner: ${trip['facilityOwner']}"),
              Text("Waste Details: ${trip['wasteDetails']}"),
              Text("Request Date: ${trip['requestDate']}"),
              const SizedBox(height: 10),
              Text("Status: ${trip['status']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
