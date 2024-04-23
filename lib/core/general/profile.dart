import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/utils/constants/colors.dart';

import '../../utils/constants/api_constants.dart';
import '../LoginMaster/update_user.dart';

class UserProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _userData = widget.user;
  }

  Future<void> onDeletePressed(BuildContext context) async {
    // Show a confirmation dialog before deleting the user
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false to indicate cancellation
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true to indicate confirmation
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    // If the user confirms deletion, proceed with deletion logic
    if (confirmDelete == true) {
      try {
        final SharedPreferences sp = await SharedPreferences.getInstance();
        final String? secretCode = sp.getString("SECRET_TOKEN");

        final Dio dio = Dio();

        dio.options = BaseOptions(
          baseUrl: ApiConstants().base,
          connectTimeout: const Duration(milliseconds: 10 * 1000),
          receiveTimeout: const Duration(milliseconds: 10 * 1000),
          sendTimeout: const Duration(milliseconds: 10 * 1000),
        );

        dio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: print,
          ),
        );

        if (kDebugMode) {
          print("Sending login request to the server...");
        }

        final response = await dio.delete(
          ApiConstants().deleteUser,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'authorization': 'Bearer $secretCode',
            },
            validateStatus: (status) => status! < 1000,
          ),
          data: {
            "email": _userData['email'] as String, // Changed from user to _userData
          },
        );


        if (response.statusCode == 200) {
          // Show a confirmation message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User deleted successfully.'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate back to the previous screen
          Navigator.pop(context);
        } else {
          // Show an error message if the request was not successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete user.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Handle errors
        print('Error deleting user: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> onUpdateUserData(Map<String, dynamic> newData) async {
    setState(() {
      _userData = newData;
    });
  }

  Future<void> onEditPressed(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          userData: _userData,
          onUpdateUserData: onUpdateUserData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.oxfordBlue,
      appBar: AppBar(
        title: const Text('User Profile', style: TextStyle(color: MyColors.csvBlack,),),
        backgroundColor: MyColors.orangeWeb,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: MyColors.csvBlack,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: MyColors.csvBlack,),
            onPressed: () => onEditPressed(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: MyColors.csvBlack,),
            onPressed: () {
              onDeletePressed(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.platinum, // Change the color as needed
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      // _userData['photo'] ??
                      'assets/logo.jpg', // Replace with the placeholder image path
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Username: ${_userData['username'] ?? 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${_userData['email'] ?? 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Mobile 1: ${_userData['mobile1'] ?? 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Mobile 2: ${_userData['mobile2'] ?? 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Aadhaar: ${_userData['aadhar'] ?? 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Driving Licence: ${_userData['driving_licence'] ?? 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'User Role: ${_userData['userRole'] != null ? getUserRole(_userData['userRole']) : 'N/A'}', // Changed from user to _userData
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String getUserRole(int? role) {
    switch (role) {
      case 0:
        return 'Admin';
      case 1:
        return 'Login Master';
      case 2:
        return 'Employee';
      default:
        return 'N/A';
    }
  }
}
