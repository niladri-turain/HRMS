class ApiEndPoints {
  static const String baseUrl = "http://192.168.0.237:8000/api/v1/";
  static const String login = "auth/login";
  static const forgotPassword = "auth/forgot-password";
  static const resetPassword = "auth/reset-password";
  static const otpVerify = "auth/verify-otp";
  static const logout ="auth/logout";


  //Marketing Manager
  static const employeeList = "marketing/team/employees";
  static String employeeJourney(String id) => "marketing/team/employees/$id/journey";

}
