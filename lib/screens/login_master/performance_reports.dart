import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceSummaryPage extends StatefulWidget {
  @override
  _PerformanceSummaryPageState createState() => _PerformanceSummaryPageState();
}

class _PerformanceSummaryPageState extends State<PerformanceSummaryPage> {
  List<Map<String, dynamic>> summaryData = [
    {"name": "Alice Johnson", "tasks": 60, "efficiency": 4.7},
    {"name": "Robert Green", "tasks": 40, "efficiency": 4.1},
    {"name": "David Lee", "tasks": 55, "efficiency": 4.8},
    {"name": "Emma Clark", "tasks": 25, "efficiency": 3.5},
    {"name": "Chris Martin", "tasks": 30, "efficiency": 4.3},
  ];

  String searchQuery = "";
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSummary = summaryData
        .where((item) =>
        item["name"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Summary",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSearchAndFilter(),
            SizedBox(height: 10),
            _buildCharts(),
            SizedBox(height: 10),
            Expanded(child: _buildSummaryList(filteredSummary)),
          ],
        ),
      ),
    );
  }

  // 🔍 Search & Filter Section
  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search employees...",
              prefixIcon: Icon(Icons.search, color: Colors.teal),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.teal)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.calendar_today, color: Colors.teal, size: 28),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
        ),
      ],
    );
  }

  // 📊 Charts Section (Bar & Pie)
  Widget _buildCharts() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: summaryData
                      .map((data) => BarChartGroupData(
                    x: summaryData.indexOf(data),
                    barRods: [
                      BarChartRodData(
                        toY: data["tasks"].toDouble(),
                        color: Colors.orange,
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                      )
                    ],
                  ))
                      .toList(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) =>
                              Text(value.toInt().toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                        )),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          return Text(summaryData[index]["name"].split(" ")[0],
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: PieChart(
            PieChartData(
              sections: summaryData.map((data) {
                return PieChartSectionData(
                  value: data["efficiency"],
                  title: "${data["efficiency"]}",
                  color: Colors
                      .primaries[summaryData.indexOf(data) % Colors.primaries.length],
                  radius: 50,
                  titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                );
              }).toList(),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }

  // 📋 Employee List Section
  Widget _buildSummaryList(List<Map<String, dynamic>> filteredSummary) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: filteredSummary.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getEfficiencyColor(filteredSummary[index]["efficiency"]),
              child: Text(
                filteredSummary[index]["efficiency"].toString(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              filteredSummary[index]["name"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text("Tasks Completed: ${filteredSummary[index]["tasks"]}"),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
            onTap: () {
              _showEmployeeDetails(filteredSummary[index]);
            },
          ),
        );
      },
    );
  }

  // 🎨 Get Color Based on Efficiency
  Color _getEfficiencyColor(double efficiency) {
    if (efficiency >= 4.5) return Colors.green;
    if (efficiency >= 4.0) return Colors.blue;
    if (efficiency >= 3.5) return Colors.orange;
    return Colors.red;
  }

  // ℹ️ Show Employee Details
  void _showEmployeeDetails(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(employee["name"], textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tasks Completed: ${employee["tasks"]}", style: TextStyle(fontSize: 16)),
            Text("Efficiency: ${employee["efficiency"]}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: employee["efficiency"] / 5,
              backgroundColor: Colors.grey[300],
              color: _getEfficiencyColor(employee["efficiency"]),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Close", style: TextStyle(color: Colors.teal, fontSize: 16)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
