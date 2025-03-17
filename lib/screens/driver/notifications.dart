import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> unreadNotifications = [
    {"message": "New trip assigned.", "time": "5 min ago"},
    {"message": "Your trip is delayed.", "time": "20 min ago"},
    {"message": "You have a pending trip.", "time": "45 min ago"},
    {"message": "Trip completed successfully.", "time": "1 hour ago"},
  ];

  List<Map<String, dynamic>> readNotifications = [];

  // Function to mark a notification as read (with animation)
  void markAsRead(int index) {
    setState(() {
      readNotifications.insert(0, unreadNotifications[index]);
      unreadNotifications.removeAt(index);
    });
  }

  // Function to undo marking a notification as read
  void undoRead(int index) {
    setState(() {
      unreadNotifications.insert(0, readNotifications[index]);
      readNotifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text(
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange[700],
          elevation: 4,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Unread (${unreadNotifications.length})"),
              Tab(text: "Read (${readNotifications.length})"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationList(unreadNotifications, isUnread: true),
            _buildNotificationList(readNotifications, isUnread: false),
          ],
        ),
      ),
    );
  }

  // 📌 Function to build notification list for both tabs
  Widget _buildNotificationList(List<Map<String, dynamic>> notifications, {required bool isUnread}) {
    if (notifications.isEmpty) {
      return _buildEmptyState(isUnread);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return Dismissible(
          key: Key(notification["message"]),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: isUnread ? Colors.green : Colors.blue,
            child: Icon(
              isUnread ? Icons.check_circle : Icons.undo,
              color: Colors.white,
              size: 30,
            ),
          ),
          onDismissed: (direction) {
            isUnread ? markAsRead(index) : undoRead(index);
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              title: Text(
                notification["message"],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(notification["time"], style: TextStyle(color: Colors.grey[600])),
              leading: CircleAvatar(
                backgroundColor: isUnread ? Colors.orange[700] : Colors.grey[400],
                child: Icon(
                  isUnread ? Icons.notifications_active : Icons.check_circle,
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                icon: Icon(isUnread ? Icons.check_circle : Icons.undo,
                    color: isUnread ? Colors.green : Colors.blue),
                onPressed: () => isUnread ? markAsRead(index) : undoRead(index),
              ),
            ),
          ),
        );
      },
    );
  }

  // 📌 Empty State UI for No Notifications
  Widget _buildEmptyState(bool isUnread) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 10),
          Text(
            isUnread ? "No Unread Notifications" : "No Read Notifications",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
