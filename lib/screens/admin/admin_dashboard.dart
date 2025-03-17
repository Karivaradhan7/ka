import 'package:flutter/material.dart';
import 'manage_users_screen.dart';
import 'reports_screen.dart';
import 'notifications_screen.dart';
import 'dashboard_screen.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    ManageUsersScreen(),
    ReportsScreen(),
    NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.green[700],
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 0 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0 ? Colors.green[700]!.withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.dashboard, size: _selectedIndex == 0 ? 30 : 25),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 1 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1 ? Colors.green[700]!.withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.people, size: _selectedIndex == 1 ? 30 : 25),
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 2 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 2 ? Colors.green[700]!.withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.bar_chart, size: _selectedIndex == 2 ? 30 : 25),
                ),
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == 3 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 3 ? Colors.green[700]!.withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications, size: _selectedIndex == 3 ? 30 : 25),
                ),
                label: 'Alerts',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
