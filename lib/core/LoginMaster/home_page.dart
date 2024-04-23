import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_app/auth/login_page.dart';
import 'package:wm_app/utils/constants/colors.dart';
import '../../utils/components/show_toast.dart';
import '../../utils/components/text_button.dart';
import '../../utils/constants/api_constants.dart';
import '../../core/LoginMaster/create_user.dart';
import '../../core/LoginMaster/view_users.dart';

class LMHomePage extends StatefulWidget {
  const LMHomePage({super.key});

  @override
  LMHomePageState createState() => LMHomePageState();
}

class LMHomePageState extends State<LMHomePage> {
  late double adminsCount = 0;
  late double driversCount = 0;
  late double loginMasterCount = 0;
  late String username = '';

  @override
  void initState() {
    super.initState();
    _getUserCounts();
    _getUsername();
  }

  bool isLoading = false;

  // Method to get username from SharedPreferences
  Future<void> _getUsername() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? storedUsername = sp.getString("userName");
    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
      });
    }
  }

  Future<int?> getUserCount(String userRole) async {
    try {
      setState(() {
        isLoading = true;
      });

      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? secretCode = sp.getString("SECRET_TOKEN");

      final dio = Dio();

      // Configure Dio instance
      dio.options = BaseOptions(
        baseUrl: ApiConstants().base,
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000),
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
        ApiConstants().getUserCount,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $secretCode',
          },
          validateStatus: (status) => status! < 1000,
        ),
        data: {
          "userRole": userRole,
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("-==================");
          print(response.data);
        }
        return response.data['userCount'] as int?;
      } else if (response.statusCode == 500) {
        showToast('No users found.');
        return null;
      } else {
        showToast('Failed to get user count. Please try again later.');
        return null;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        showToast('Connection timeout. Please try again later.');
      } else if (e.type == DioExceptionType.badResponse) {
        showToast(
            'Error ${e.response?.statusCode}: ${e.response?.statusMessage}');
      } else {
        showToast('An error occurred: ${e.message}');
      }

      return null;
    } on Exception catch (e) {
      showToast('An error occurred: $e');
      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getUserCounts() async {
    try {
      num admins = await getUserCount('0') ?? 0;
      num drivers = await getUserCount('2') ?? 0;
      num loginMasters = await getUserCount('1') ?? 0;
      setState(() {
        adminsCount = admins.toDouble();
        driversCount = drivers.toDouble();
        loginMasterCount = loginMasters.toDouble();
      });
    } catch (error) {
      if (kDebugMode) {
        print('Failed to fetch user counts: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.csvOxfordBlue, // Change background color
      appBar: AppBar(
        backgroundColor: MyColors.withHashOrangeWeb, // Change app bar color
        title: Text(
          'Welcome, $username!', // Replace with actual username variable
          style: TextStyle(
            color: MyColors.withHashBlack, // Change text color
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: MyColors.csvBlack,
            ),
            onPressed: () {
              // Navigate to settings page
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: MyColors.csvBlack,
            ),
            onPressed: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();

              await sp.setBool('isLogin', false);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedCard(
                color: Colors.blue, // Change card color
                child: adminsCount != null && driversCount != null
                    ? PieChart(
                        chartType: ChartType.ring,
                        animationDuration: const Duration(seconds: 1),
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 1.5,
                        dataMap: {
                          'Admins': adminsCount,
                          'Drivers/Employees': driversCount,
                          'Login Masters': loginMasterCount,
                        },
                        colorList: const [
                          MyColors.withHashBlack,
                          MyColors.withHashOrangeWeb,
                          MyColors.platinum,
                        ],
                      )
                    : const CircularProgressIndicator(),
              ),
              const Divider(height: 50.0),
              ElevatedCard(
                color: Colors.blue, // Change card color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyButton(
                      // Use MyButton for "Create User"
                      text: 'Create User',
                      icon: Icons.add,
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) {
                              return const CreateUser();
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    MyButton(
                      // Use MyButton for "View Users"
                      text: 'View Users',
                      icon: Icons.list,
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) {
                              return const ViewUsers();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedCard extends StatelessWidget {
  final Widget child;
  final Color color;

  const ElevatedCard({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 25, 15, 25),
          child: child,
        ),
      ),
    );
  }
}
