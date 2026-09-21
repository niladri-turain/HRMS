import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _phoneKey = 'phone';
  static const String _employeeIdKey = 'employee_id';
  static const String _employeeCodeKey = 'employee_code';
  static const String _designationCodeKey = 'designation_code';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _dashboardSessionKey = 'dashboard_session';

  Future<void> saveUserData({
    required String token,
    required String userId,
    required String username,
    required String name,
    required String email,
    required String phone,
    required String employeeId,
    required String employeeCode,
    required String designationCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_phoneKey, phone);
    await prefs.setString(_employeeIdKey, employeeId);
    await prefs.setString(_employeeCodeKey, employeeCode);
    await prefs.setString(_designationCodeKey, designationCode);
    await prefs.setBool(_isLoggedInKey, true);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneKey);
  }

  Future<String?> getEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_employeeIdKey);
  }

  Future<String?> getEmployeeCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_employeeCodeKey);
  }

  Future<String?> getDesignationCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_designationCodeKey);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveDashboardSession(String session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dashboardSessionKey, session);
  }

  Future<String?> getDashboardSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dashboardSessionKey);
  }
}
