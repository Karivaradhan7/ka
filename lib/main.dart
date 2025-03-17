import 'package:flutter/material.dart';
import 'package:waste_management/screens/login_signup.dart';
import 'package:waste_management/screens/role_selection.dart';
import 'package:waste_management/screens/facility_owner/facility_owner_dashboard.dart';
import 'package:waste_management/screens/admin/admin_dashboard.dart';
import 'package:waste_management/screens/driver/driver_dashboard.dart';
import 'package:waste_management/screens/login_master/login_master_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waste Management App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(), // App starts with the login screen
      routes: {
        '/roleSelection': (context) => RoleSelectionScreen(), // Role selection page
        '/facilityOwnerDashboard': (context) => FacilityOwnerDashboard(),
        '/adminDashboard': (context) => AdminDashboard(),
        '/driverDashboard': (context) => DriverDashboard(),
        '/loginMasterDashboard': (context) => LoginMasterDashboard(),
      },
    );
  }
}
