class ApiEndPoints {
  static const String baseUrl = "https://hrms.onlinedemo.in.net/api/v1/";
  static const String login = "auth/login";
  static const forgotPassword = "auth/forgot-password";
  static const resetPassword = "auth/reset-password";
  static const otpVerify = "auth/verify-otp";
  static const logout ="auth/logout";
  static const employeeClientVisitList ="marketing/client-visits/my";


  //Marketing Manager
  static const employeeList = "marketing/team/employees";
  static const managerClientVisitList ="marketing/client-visits";
  static String employeeJourney(String id) => "marketing/team/employees/$id/journey";


}
