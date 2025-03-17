import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {"title": "Request Submitted Successfully", "message": "Your request has been received.", "isRead": false},
    {"title": "Payment Confirmed", "message": "Your payment for waste collection is confirmed.", "isRead": false},
    {"title": "New Driver Assigned", "message": "A driver has been assigned to collect waste.", "isRead": false},
    {"title": "Request Moved to Upcoming", "message": "Your request is now in upcoming status.", "isRead": true},
    {"title": "Request Completed", "message": "Your request has been completed successfully.", "isRead": true},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green[700],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Unread"),
              Tab(text: "Read"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _notificationsList(false), // Unread Notifications
            _notificationsList(true),  // Read Notifications
          ],
        ),
      ),
    );
  }

  /// ✅ **Notification List**
  Widget _notificationsList(bool isRead) {
    List<Map<String, dynamic>> filteredNotifications =
    notifications.where((notification) => notification["isRead"] == isRead).toList();

    return filteredNotifications.isEmpty
        ? Center(child: Text("No notifications", style: TextStyle(fontSize: 16, color: Colors.grey)))
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        return _notificationTile(filteredNotifications[index]);
      },
    );
  }

  /// ✅ **Enhanced Notification Tile**
  Widget _notificationTile(Map<String, dynamic> notification) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(notification["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(notification["message"], style: TextStyle(fontSize: 14, color: Colors.black87)),
        ),
        leading: CircleAvatar(
          backgroundColor: notification["isRead"] ? Colors.grey[300] : Colors.orange[300],
          child: Icon(Icons.notifications, color: notification["isRead"] ? Colors.grey[700] : Colors.orange[800]),
        ),
        trailing: !notification["isRead"]
            ? TextButton(
          onPressed: () {
            setState(() {
              notification["isRead"] = true;
            });
          },
          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
          child: Text("Mark as Read", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        )
            : null,
      ),
    );
  }
}
