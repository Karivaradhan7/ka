import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/utils/components/show_toast.dart';
import '../../utils/components/text_button.dart';
import '../../utils/components/text_field.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/constants/colors.dart';
import '../../utils/components/dropdown.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  CreateUserState createState() => CreateUserState();
}

class CreateUserState extends State<CreateUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController drivingLicenseController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  String? selectedUserRole;
  bool isLoading = false;

  File? _imageFile;

  void _camera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _register() async {
    try {
      // Set loading state
      setState(() {
        isLoading = true;
      });

      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? secretCode = sp.getString("SECRET_TOKEN");

      // Initialize Dio
      final dio = Dio();
      dio.options = BaseOptions(
        baseUrl: ApiConstants().base,
        connectTimeout: const Duration(milliseconds: 10 * 1000),
        receiveTimeout: const Duration(milliseconds: 10 * 1000),
        sendTimeout: const Duration(milliseconds: 10 * 1000),
      );

      // Add interceptors
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: print,
        ),
      );

      // Debug log
      if (kDebugMode) {
        print("Sending registration request to the server...");
        print("Username: ${usernameController.text.trim()}");
        print("Email: ${emailController.text.trim()}");
        print("Mobile 1: ${mobile1Controller.text.trim()}");
        print("Mobile 2: ${mobile2Controller.text.trim()}");
        print("Aadhar: ${aadharController.text.trim()}");
        print("Driving License: ${drivingLicenseController.text.trim()}");
        print("Role: ${roleController.text.trim()}");
      }

      // Make the registration request
      final response = await dio.post(
        ApiConstants().addUser,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $secretCode',
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          // Pass registration data here
          "userName": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "mobile1": mobile1Controller.text.trim(),
          "mobile2": mobile2Controller.text.trim().isNotEmpty ? mobile2Controller.text.trim() : "",
          "aadhar": aadharController.text.trim(),
          "photo": "photo.jpg",
          "dri_licence": drivingLicenseController.text.trim().isNotEmpty ? drivingLicenseController.text.trim() : "",
          "role": selectedUserRole,
        },
      );

      // Debug log
      if (kDebugMode) {
        print(response.data);
      }

      // Handle response based on status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast("User Added");
      } else {
        showToast("Registration failed: ${response.data}");
      }
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.type == DioExceptionType.connectionTimeout) {
        showToast("Connection timeout. Please try again later.");
        if (kDebugMode) {
          print("Connection timeout. Please try again later.: $e");
        }
      } else if (e.type == DioExceptionType.badResponse) {
        showToast(
            "Error ${e.response?.statusCode}: ${e.response?.statusMessage}");
      } else {
        showToast("An error occurred: $e");
      }

    } finally {
      // Set loading state to false
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.oxfordBlue,
      appBar: AppBar(
        backgroundColor: MyColors.orangeWeb,
        title: const Text('Create User'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.platinum, // Placeholder color
                        ),
                        child: _imageFile != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.file(
                            _imageFile!,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Icon(
                          Icons.person_outline,
                          size: 100.0,
                          color: MyColors.white,
                        ), // Default icon
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.platinum,
                          ),
                          child: IconButton(
                            onPressed: _camera,
                            icon: const Icon(Icons.camera_alt_outlined),
                            color: MyColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyButton(
                    onTap: _pickImage,
                    text: 'Select Photo',
                    icon: Icons.photo,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              MyTextField(
                controller: usernameController,
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                labelText: "Username",
                hintText: "Username",
                obscureText: false,
                keyboardType: TextInputType.name,
                enabled: true,
              ),
              const SizedBox(height: 20.0),

              MyTextField(
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
                validator: null,
                labelText: "Email",
                hintText: "Email",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                enabled: true,
              ),
              const SizedBox(height: 20.0),

              MyTextField(
                controller: mobile1Controller,
                prefixIcon: const Icon(Icons.phone_android),
                validator: null,
                labelText: "Mobile 1",
                hintText: "Mobile 1",
                obscureText: false,
                keyboardType: TextInputType.phone,
                enabled: true,
              ),
              const SizedBox(height: 20.0),

              MyTextField(
                controller: mobile2Controller,
                prefixIcon: const Icon(Icons.phone_android),
                validator: null,
                labelText: "Mobile 2 (Optional)",
                hintText: "Mobile 2",
                obscureText: false,
                keyboardType: TextInputType.phone,
                enabled: true,
              ),
              const SizedBox(height: 20.0),

              MyTextField(
                controller: aadharController,
                prefixIcon: const Icon(Icons.credit_card),
                validator: null,
                labelText: "Aadhar Number",
                hintText: "Aadhar Number",
                obscureText: false,
                keyboardType: TextInputType.number,
                enabled: true,
              ),
              const SizedBox(height: 20.0),

              MyTextField(
                controller: drivingLicenseController,
                prefixIcon: const Icon(Icons.card_membership),
                validator: null,
                labelText: "Driving License",
                hintText: "Driving License Number",
                obscureText: false,
                keyboardType: TextInputType.text,
                enabled: true,
              ),
              const SizedBox(height: 20.0),

              MyDropdownFormField(
                value: selectedUserRole,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a user role';
                  }
                  return null;
                },
                onChanged: (newValue) {
                  setState(() {
                    selectedUserRole = newValue;
                  });
                },
                items: [
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
                hintText: 'Select User Role',
              ),
              const SizedBox(height: 20.0),
              MyButton(
                icon: null,
                onTap: _register,
                text: 'Create User',
                borderColor: MyColors.orangeWeb,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
