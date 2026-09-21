import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';
import 'package:hrms_app/feature/model/login_model.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;
  final SharedPrefService prefService;

  LoginProvider({required this.apiService, required this.prefService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LoginModel? _loginModel;
  LoginModel? get loginModel => _loginModel;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndPoints.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        _loginModel = LoginModel.fromJson(response.data);
        
        if (_loginModel?.success == true && _loginModel?.data != null) {
          final data = _loginModel!.data!;
          final user = data.user!;
          final employee = user.employee!;

          await prefService.saveUserData(
            token: data.token ?? '',
            userId: user.id ?? '',
            username: user.username ?? '',
            name: employee.name ?? '',
            email: user.email ?? '',
            phone: employee.mobile ?? '',
            employeeId: employee.id ?? '',
            employeeCode: employee.employeeCode ?? '',
            designationCode: employee.designation?.code ?? '',
          );

          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = _loginModel?.message ?? 'Login failed';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        _errorMessage = response.data['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.post(ApiEndPoints.logout);

      if (response.statusCode == 200) {
        await prefService.clear();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.data['message'] ?? 'Logout failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Even if API fails, we should clear local storage to let user "log out"
      await prefService.clear();
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return true; // Return true because session is cleared locally
    }
  }
}
