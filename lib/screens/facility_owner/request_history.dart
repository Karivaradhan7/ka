import 'package:flutter/material.dart';
import 'dart:ui';

class RequestHistoryScreen extends StatefulWidget {
  @override
  _RequestHistoryScreenState createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  List<Map<String, dynamic>> pendingRequests = [
    {"id": "REQ123", "waste": "10kg Solid", "time": "10:00 AM"},
    {"id": "REQ124", "waste": "5kg Liquid", "time": "12:30 PM"},
  ];

  List<Map<String, dynamic>> upcomingRequests = [
    {"id": "REQ125", "waste": "8kg Solid", "time": "2:00 PM", "collected": false, "paid": false},
    {"id": "REQ126", "waste": "3kg Liquid", "time": "4:00 PM", "collected": true, "paid": false},
  ];

  List<Map<String, dynamic>> completedRequests = [
    {"id": "REQ120", "waste": "15kg Solid", "time": "8:00 AM"},
    {"id": "REQ121", "waste": "6kg Liquid", "time": "9:00 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Request History", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: [
                  Tab(text: "Upcoming"),
                  Tab(text: "Pending"),
                  Tab(text: "Completed"),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green.shade900, Colors.green.shade400],
                ),
              ),
            ),

            // Blurred Container
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            ),

            // Tabs View
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: TabBarView(
                children: [
                  _buildUpcomingTab(),
                  _buildPendingTab(),
                  _buildCompletedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Upcoming Requests Tab
  Widget _buildUpcomingTab() {
    return _buildRequestList(upcomingRequests, (request) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Collected: ${request['collected'] ? '✅ Yes' : '❌ No'}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text("Paid: ${request['paid'] ? '✅ Yes' : '❌ No'}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      );
    });
  }

  // Pending Requests Tab
  Widget _buildPendingTab() {
    return pendingRequests.isEmpty
        ? _buildNoRequestsMessage("No Pending Requests")
        : ListView.builder(
      itemCount: pendingRequests.length,
      itemBuilder: (context, index) {
        var request = pendingRequests[index];
        return _buildRequestCard(
          request,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: "edit$index",
                backgroundColor: Colors.orange.shade600,
                mini: true,
                child: Icon(Icons.edit),
                onPressed: () => _modifyRequest(request),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                heroTag: "delete$index",
                backgroundColor: Colors.red.shade600,
                mini: true,
                child: Icon(Icons.delete),
                onPressed: () => _deleteRequest(request),
              ),
            ],
          ),
        );
      },
    );
  }

  // Completed Requests Tab
  Widget _buildCompletedTab() {
    return _buildRequestList(completedRequests, (_) => SizedBox());
  }

  // Common Request List UI
  Widget _buildRequestList(List<Map<String, dynamic>> requests, Widget Function(Map<String, dynamic>) trailingBuilder) {
    return requests.isEmpty
        ? _buildNoRequestsMessage("No Requests Found")
        : ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        var request = requests[index];
        return _buildRequestCard(request, trailing: trailingBuilder(request));
      },
    );
  }

  // Request Card UI (Glassmorphic)
  Widget _buildRequestCard(Map<String, dynamic> request, {Widget? trailing}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: ListTile(
        title: Text(
          "Request ID: ${request['id']}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            "Waste: ${request['waste']}\nTime: ${request['time']}",
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.white70),
          ),
        ),
        trailing: trailing,
      ),
    );
  }

  // No Requests UI
  Widget _buildNoRequestsMessage(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 60, color: Colors.white54),
          SizedBox(height: 10),
          Text(message, style: TextStyle(fontSize: 16, color: Colors.white70)),
        ],
      ),
    );
  }

  // Modify Request
  void _modifyRequest(Map<String, dynamic> request) {
    TextEditingController wasteController = TextEditingController(text: request["waste"]);
    TextEditingController timeController = TextEditingController(text: request["time"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modify Request"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: wasteController, decoration: InputDecoration(labelText: "Waste Quantity")),
              TextField(controller: timeController, decoration: InputDecoration(labelText: "Time Slot")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(onPressed: () => setState(() { request["waste"] = wasteController.text; request["time"] = timeController.text; Navigator.pop(context); }), child: Text("Save")),
          ],
        );
      },
    );
  }

  // Delete Request
  void _deleteRequest(Map<String, dynamic> request) {
    setState(() {
      pendingRequests.removeWhere((r) => r['id'] == request['id']);
    });
  }
}


