import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> unreadNotifications = [
    "Request Submitted Successfully.",
    "Your request has moved to 'Upcoming'.",
    "Driver Assigned to your request.",
    "Your request is completed with payment confirmation."
  ];

  List<String> readNotifications = [];

  void markAsRead(int index) {
    setState(() {
      readNotifications.add(unreadNotifications[index]);
      unreadNotifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Back Button & Page Title (Like Request History Page)**
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              children: [
                /// **Back Button**
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 28, color: Colors.purple),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                /// **Page Title**
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          /// **Tabs for Read & Unread Notifications**
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  /// **Tab Bar**
                  TabBar(
                    labelColor: Colors.purple,
                    indicatorColor: Colors.purple,
                    tabs: [
                      Tab(text: "Unread (${unreadNotifications.length})"),
                      Tab(text: "Read (${readNotifications.length})"),
                    ],
                  ),

                  /// **Tab Views**
                  Expanded(
                    child: TabBarView(
                      children: [
                        /// **Unread Notifications Tab**
                        _buildNotificationList(unreadNotifications, isUnread: true),

                        /// **Read Notifications Tab**
                        _buildNotificationList(readNotifications, isUnread: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Widget for Notification List**
  Widget _buildNotificationList(List<String> notifications, {required bool isUnread}) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text(notifications[index]),
            trailing: isUnread
                ? IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: () {
                markAsRead(index);
              },
            )
                : Icon(Icons.check_circle, color: Colors.grey),
          ),
        );
      },
    );
  }
}
