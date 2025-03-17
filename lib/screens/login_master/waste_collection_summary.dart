import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WasteCollectionSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Waste Collection Summary", style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade900]),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalWasteCard(),

            SizedBox(height: 20),

            _buildChartContainer("📊 Monthly Waste Collection", _buildWasteBarChart()),

            SizedBox(height: 20),

            _buildChartContainer("🍽️ Waste Type Distribution", _buildWastePieChart()),

            SizedBox(height: 20),

            _buildChartContainer("📈 Daily Collection Trend", _buildWasteLineChart()),

            SizedBox(height: 20),

            _buildWasteSummaryTiles(),
          ],
        ),
      ),
    );
  }

  /// **🔹 Total Waste Collected Card (Enhanced UI)**
  Widget _buildTotalWasteCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade900]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text("Total Waste Collected",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Text("5,420 kg",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.yellowAccent)),
          ],
        ),
      ),
    );
  }

  /// **📊 Reusable Chart Container**
  Widget _buildChartContainer(String title, Widget chart) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            chart,
          ],
        ),
      ),
    );
  }

  /// **📊 Monthly Waste Collection Bar Chart (Smoother UI)**
  Widget _buildWasteBarChart() {
    List<int> wasteCollected = [800, 1200, 950, 1100, 1450, 1300];

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 1600,
          barGroups: List.generate(wasteCollected.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: wasteCollected[index].toDouble(),
                  gradient: LinearGradient(colors: [Colors.green.shade400, Colors.green.shade800]),
                  width: 18,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            );
          }),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text("${value.toInt()} kg", style: TextStyle(fontSize: 12)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(labels[value.toInt()], style: TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **🍽️ Waste Type Distribution Pie Chart (Better Colors & Design)**
  Widget _buildWastePieChart() {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(color: Colors.blue, value: 60, title: "Solid 60%", radius: 50),
            PieChartSectionData(color: Colors.orange, value: 40, title: "Liquid 40%", radius: 40),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  /// **📈 Daily Collection Trend Line Chart (Smooth & Stylish)**
  Widget _buildWasteLineChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey, width: 0.5)),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(1, 300),
                FlSpot(2, 500),
                FlSpot(3, 750),
                FlSpot(4, 900),
                FlSpot(5, 650),
                FlSpot(6, 1100),
              ],
              isCurved: true,
              gradient: LinearGradient(colors: [Colors.green.shade400, Colors.green.shade700]),
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [Colors.green.shade100, Colors.white])),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text("${value.toInt()} kg", style: TextStyle(fontSize: 10)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text("${meta.formattedValue}", style: TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **📌 Waste Category Summary Tiles (Enhanced)**
  Widget _buildWasteSummaryTiles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSummaryTile(Icons.delete, "Solid Waste", "3,200 kg", Colors.blue),
        _buildSummaryTile(Icons.water_drop, "Liquid Waste", "2,220 kg", Colors.orange),
      ],
    );
  }

  /// **📌 Reusable Summary Tile**
  Widget _buildSummaryTile(IconData icon, String title, String value, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
