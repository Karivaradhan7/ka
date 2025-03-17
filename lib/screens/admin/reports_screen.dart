import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildReportCard("Service Completion", _buildPieChart(), () => _generatePDF("Service Completion", "Report Content")),
            _buildReportCard("Total Waste Collected", _buildBarChart(), () => _generatePDF("Total Waste", "Report Content")),
            _buildReportCard("Waste Collection Trend", _buildLineChart(), () => _generatePDF("Waste Trend", "Report Content")),
            _buildReportCard("Payment Status Distribution", _buildDonutChart(), () => _generatePDF("Payment Status", "Report Content")),
            _buildReportCard("Cost Analysis", _buildCostCard(), () => _generatePDF("Cost Analysis", "Report Content")),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Report Card UI**
  Widget _buildReportCard(String title, Widget chart, VoidCallback generateReport) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800])),
            SizedBox(height: 10),
            chart,
            SizedBox(height: 10),
            _downloadButton("$title Report", generateReport),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Download Button**
  Widget _downloadButton(String label, VoidCallback generateReport) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.download, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
        onPressed: generateReport,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[600],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  /// 🔹 **Pie Chart (Service Completion)**
  Widget _buildPieChart() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 120, title: "Completed", color: Colors.green, radius: 65),
                PieChartSectionData(value: 25, title: "Pending", color: Colors.red, radius: 55),
              ],
              centerSpaceRadius: 45,
              sectionsSpace: 3,
            ),
          ),
        ),
        _buildLegend([
          _legendItem("Completed", Colors.green),
          _legendItem("Pending", Colors.red),
        ]),
      ],
    );
  }

  /// 🔹 **Bar Chart (Total Waste Collected)**
  Widget _buildBarChart() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              maxY: 800,
              barGroups: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 500, color: Colors.blue, width: 25)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 700, color: Colors.orange, width: 25)]),
              ],
            ),
          ),
        ),
        _buildLegend([
          _legendItem("Solid Waste", Colors.blue),
          _legendItem("Liquid Waste", Colors.orange),
        ]),
      ],
    );
  }

  /// 🔹 **Line Chart (Waste Collection Trend)**
  Widget _buildLineChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              spots: [
                FlSpot(1, 200), FlSpot(2, 400), FlSpot(3, 500),
                FlSpot(4, 700), FlSpot(5, 650), FlSpot(6, 800),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Donut Chart (Payment Status)**
  Widget _buildDonutChart() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 3000, title: "Paid", color: Colors.green, radius: 60),
                PieChartSectionData(value: 2000, title: "Pending", color: Colors.red, radius: 50),
              ],
              centerSpaceRadius: 50,
            ),
          ),
        ),
        _buildLegend([
          _legendItem("Paid", Colors.green),
          _legendItem("Pending", Colors.red),
        ]),
      ],
    );
  }

  /// 🔹 **Cost Analysis Card**
  Widget _buildCostCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple.shade300, Colors.purple.shade600]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text("Total Revenue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          Text("\$5,000", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  /// 🔹 **Legend Widget (Fixed)**
  Widget _buildLegend(List<Widget> items) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        children: items,
      ),
    );
  }

  /// 🔹 **Legend Item (Fixed)**
  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  /// 🔹 **PDF Report Generation**
  Future<void> _generatePDF(String title, String content) async {
    if (await _requestPermission()) {
      final pdf = pw.Document();
      pdf.addPage(pw.Page(build: (pw.Context context) => pw.Center(child: pw.Text(content))));
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/$title.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("PDF Saved: $filePath")));
      OpenFile.open(filePath);
    }
  }

  /// 🔹 **Request Permission**
  Future<bool> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }
}
