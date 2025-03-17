import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> notifications = [
    {"title": "Request REQ-101 Assigned", "subtitle": "Driver has been assigned", "status": "Unread"},
    {"title": "Request REQ-102 Collected", "subtitle": "Waste collected successfully", "status": "Read"},
    {"title": "Payment Received", "subtitle": "Payment completed for REQ-104", "status": "Unread"},
    {"title": "New Request Submitted", "subtitle": "REQ-105 needs to be assigned", "status": "Unread"},
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 🔹 Function to Filter Notifications
  List<Map<String, dynamic>> _filterNotifications(String status) {
    return notifications.where((n) => n["status"] == status).toList();
  }

  /// 🔹 Function to Delete Notification with Undo
  void _deleteNotification(int index, String status) {
    List<Map<String, dynamic>> filteredList = _filterNotifications(status);
    Map<String, dynamic> deletedItem = filteredList[index];

    setState(() {
      notifications.remove(deletedItem);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Notification deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              notifications.add(deletedItem);
            });
          },
        ),
      ),
    );
  }

  /// 🔹 Toggle Read/Unread Status
  void _toggleReadStatus(int index, String status) {
    List<Map<String, dynamic>> filteredList = _filterNotifications(status);
    Map<String, dynamic> updatedItem = filteredList[index];

    setState(() {
      updatedItem["status"] = updatedItem["status"] == "Unread" ? "Read" : "Unread";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Unread"),
            Tab(text: "Read"),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList("Unread"),
          _buildNotificationList("Read"),
        ],
      ),
    );
  }

  /// 🔹 Notification List Builder
  Widget _buildNotificationList(String status) {
    List<Map<String, dynamic>> filteredList = _filterNotifications(status);

    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          "No ${status.toLowerCase()} notifications",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          var notification = filteredList[index];

          return Dismissible(
            key: Key(notification["title"]),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => _deleteNotification(index, status),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.deepPurple, size: 35),
                title: Text(notification["title"], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(notification["subtitle"]),
                trailing: _statusBadge(notification["status"]),
                onTap: () => _toggleReadStatus(index, status),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Status Badge Widget
  Widget _statusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: status == "Unread" ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(color: status == "Unread" ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }
}
