import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/utils/constants/colors.dart';

import '../../utils/components/show_toast.dart';
import '../../utils/components/text_button.dart';
import '../../utils/components/text_field.dart';
import '../../utils/constants/api_constants.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Function(Map<String, dynamic>) onUpdateUserData;

  const EditProfilePage(
      {super.key, required this.userData, required this.onUpdateUserData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _mobile1Controller;
  late TextEditingController _mobile2Controller;
  late TextEditingController _aadharController;
  late TextEditingController _drivingLicenceController;
  late TextEditingController _roleController;

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.userData['username']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _mobile1Controller =
        TextEditingController(text: widget.userData['mobile1']);
    _mobile2Controller =
        TextEditingController(text: widget.userData['mobile2']);
    _aadharController = TextEditingController(text: widget.userData['aadhar']);
    _drivingLicenceController =
        TextEditingController(text: widget.userData['driving_licence']);
    _roleController =
        TextEditingController(text: widget.userData['userRole'].toString());
  }

  Future<void> updateUser({
    required String userName,
    required String email,
    required String mobile1,
    required String mobile2,
    required String aadhar,
    required String photo,
    required String driLicence,
    required int role,
  }) async {
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

      final response = await dio.put(
        ApiConstants().updateUser,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $secretCode',
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          'userName': userName,
          'email': email,
          'mobile1': mobile1,
          'mobile2': mobile2,
          'aadhar': aadhar,
          'photo': photo,
          'dri_licence': driLicence,
          'role': role,
        },
      );

      if (response.statusCode == 200) {
        // Create a new map with updated user data
        Map<String, dynamic> updatedUserData = {
          'username': userName,
          'email': email,
          'mobile1': mobile1,
          'mobile2': mobile2,
          'aadhar': aadhar,
          'driving_licence': driLicence,
          'userRole': role,
        };

        // Call the callback function to update user data in UserProfilePage
        widget.onUpdateUserData(updatedUserData);

        // User information updated successfully
        showToast('User information updated!');
        Navigator.pop(context);
      } else if (response.statusCode == 400) {
        showToast('Bad Request: Incorrect credentials');
      } else if (response.statusCode == 401) {
        showToast('Unauthorized Access');
      } else if (response.statusCode == 500) {
        showToast('Internal Server Error');
      } else {
        showToast('Unknown Error');
      }
    } catch (e) {
      showToast('Error updating user: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _mobile1Controller.dispose();
    _mobile2Controller.dispose();
    _aadharController.dispose();
    _drivingLicenceController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.oxfordBlue,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: MyColors.csvBlack),
        ),
        backgroundColor: MyColors.orangeWeb,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: MyColors.csvBlack),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                controller: _usernameController,
                prefixIcon: Icon(Icons.person, color: MyColors.csvBlack),
                labelText: 'Username',
                hintText: 'Enter your username',
                obscureText: false,
                keyboardType: TextInputType.text,
                enabled: true,
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: _emailController,
                prefixIcon: Icon(Icons.email, color: MyColors.csvBlack),
                labelText: 'Email',
                hintText: 'Enter your email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                enabled: true,
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: _mobile1Controller,
                prefixIcon: Icon(Icons.phone, color: MyColors.csvBlack),
                labelText: 'Mobile 1',
                hintText: 'Enter your mobile number',
                obscureText: false,
                keyboardType: TextInputType.phone,
                enabled: true,
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: _mobile2Controller,
                prefixIcon: Icon(Icons.phone, color: MyColors.csvBlack),
                labelText: 'Mobile 2',
                hintText: 'Enter your another mobile number',
                obscureText: false,
                keyboardType: TextInputType.phone,
                enabled: true,
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: _aadharController,
                prefixIcon: Icon(Icons.credit_card, color: MyColors.csvBlack),
                labelText: 'Aadhaar',
                hintText: 'Enter your Aadhaar number',
                obscureText: false,
                keyboardType: TextInputType.number,
                enabled: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: _drivingLicenceController,
                prefixIcon: Icon(Icons.drive_eta, color: MyColors.csvBlack),
                labelText: 'Driving Licence',
                hintText: 'Enter your driving licence number',
                obscureText: false,
                keyboardType: TextInputType.text,
                enabled: true,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _roleController,
                prefixIcon: Icon(Icons.person, color: MyColors.csvBlack),
                labelText: 'Role',
                hintText: 'Enter the new role',
                obscureText: false,
                keyboardType: TextInputType.number,
                enabled: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: () {
                  updateUser(
                    userName: _usernameController.text,
                    email: _emailController.text,
                    mobile1: _mobile1Controller.text,
                    mobile2: _mobile2Controller.text,
                    aadhar: _aadharController.text,
                    photo: '', // Pass your photo string here
                    driLicence: _drivingLicenceController.text,
                    role: int.parse(_roleController.text), // Parse role to int
                  );
                },
                text: 'Save',
                icon: null,
                borderColor: MyColors.orangeWeb,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
