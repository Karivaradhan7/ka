import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wm_app/utils/components/show_toast.dart';
import 'package:wm_app/utils/constants/api_constants.dart';
import 'package:wm_app/utils/components/dropdown.dart';
import 'package:wm_app/utils/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/utils/components/text_button.dart';

import '../general/profile.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({super.key});

  @override
  ViewUsersState createState() => ViewUsersState();
}

class ViewUsersState extends State<ViewUsers> {
  String? _selectedUserRole;
  List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    // Fetch users when the page is initialized
    if (_selectedUserRole != null) {
      _fetchUsers();
    }
  }

  Future<void> _fetchUsers() async {
    try {
      if (kDebugMode) {
        print("Fetching users... ");
        print("Selected user role: $_selectedUserRole");
      }
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

      final response = await dio.get(
        ApiConstants().getUser,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $secretCode',
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          "userRole": _selectedUserRole,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _users = response.data[
              'result']; // Assuming the list of users is in a 'result' key
        });
      } else if (response.statusCode == 400) {
        showToast('Users not found');
      } else if (response.statusCode == 401) {
        showToast('Unauthorized Access');
      } else if (response.statusCode == 500) {
        showToast('Internal Server Error');
      } else {
        showToast('Unknown Error');
      }
    } catch (e) {
      showToast('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.oxfordBlue,
      appBar: AppBar(
        title: const Text(
          'View Users',
          style: TextStyle(
            color: MyColors.csvBlack,
          ),
        ),
        backgroundColor: MyColors.orangeWeb,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: MyColors.csvBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            MyDropdownFormField(
              value: _selectedUserRole,
              onChanged: (newValue) {
                setState(() {
                  _selectedUserRole = newValue;
                  _users.clear(); // Clear the list when the role is changed
                });
              },
              items: const [
                DropdownMenuItem(
                  value: '0',
                  child: Text('Admin'),
                ),
                DropdownMenuItem(
                  value: '1',
                  child: Text('Login Master'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('Employee'),
                ),
              ],
              prefixIcon: Icon(Icons.person),
              labelText: 'Role',
              hintText: 'Select User Role', // Changed to string
            ),
            SizedBox(height: 20),
            MyButton(
              icon: null,
              onTap: _fetchUsers,
              text: 'Fetch Users',
              borderColor: MyColors.orangeWeb,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _users.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 40,
                            color: Colors.red,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No users found',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the person's profile page here
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) {
                                  return UserProfilePage(user: user);
                                },
                              ),
                            );
                          },
                          child: Card(
                            color: MyColors.platinum,
                            child: ListTile(
                              title: user['username'] != null
                                  ? Text(
                                      user['username'],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  : const Text(
                                      'No username',
                                      style: TextStyle(color: Colors.black),
                                    ),
                              subtitle: user['email'] != null
                                  ? Text(
                                      user['email'],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  : const Text(
                                      'No email',
                                      style: TextStyle(color: Colors.black),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
