class ApiConstants {
  static const String baseUrl = 'https://22c1-45-127-59-91.ngrok-free.app/api';
  final String base = 'https://22c1-45-127-59-91.ngrok-free.app/api';

  // Authentication
  String signUp = '$baseUrl/auth/signUp';
  String forgotPassword = '$baseUrl/auth/forgotPassword';
  String verifyOTP = '$baseUrl/auth/verifyOTP';
  String login = '$baseUrl/auth/login';

  // User
  String addUser = '$baseUrl/user/addUser';
  String deleteUser = '$baseUrl/user/deleteUser';
  String getUser = '$baseUrl/user/getUser';
  String updateUser = '$baseUrl/user/updateUser';
  String getUserCount = '$baseUrl/user/getUserCount';

  // Category
  String addCategory = '$baseUrl/category/addCategory';
  String getCategory = '$baseUrl/category/getCategory';
  String deleteCategory = '$baseUrl/category/deleteCategory';

  // Facility
  String addFacility = '$baseUrl/facility/addFacility';
  String getFacility = '$baseUrl/facility/getFacility';
  String updateFacility = '$baseUrl/facility/updateFacility';
  String deleteFacility = '$baseUrl/facility/deleteFacility';

  // Waste Collection Status
  String addWasteStat = '$baseUrl/stat/addWasteStat';
  String getWasteStat = '$baseUrl/stat/getWasteStat';
  String deleteWasteStat = '$baseUrl/stat/deleteWasteStat';
}
