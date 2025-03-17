import 'package:flutter/material.dart';

class FuelDistanceTrackerPage extends StatelessWidget {
  final List<Map<String, dynamic>> trips = [
    {"trip": "#1234", "distance": "25 km", "fuel": "2.5 L"},
    {"trip": "#1235", "distance": "18 km", "fuel": "1.8 L"},
    {"trip": "#1236", "distance": "32 km", "fuel": "3.2 L"},
    {"trip": "#1237", "distance": "40 km", "fuel": "4.0 L"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Fuel & Distance Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: trips.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return _buildTripCard(
              trips[index]["trip"]!,
              trips[index]["distance"]!,
              trips[index]["fuel"]!,
            );
          },
        ),
      ),
    );
  }

  // Trip Info Card
  Widget _buildTripCard(String trip, String distance, String fuel) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        leading: Icon(Icons.local_gas_station, color: Colors.brown[600], size: 32),
        title: Text(
          "Trip $trip",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Distance: $distance | Fuel: $fuel",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        trailing: Icon(Icons.directions_car, color: Colors.brown[400], size: 30),
      ),
    );
  }
}
