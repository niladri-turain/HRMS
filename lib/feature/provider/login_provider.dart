import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;
  final SharedPrefService prefService;

  LoginProvider({required this.apiService, required this.prefService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = data['user'];
        final employee = user['employee'];

        await prefService.saveUserData(
          token: data['token'],
          userId: user['id'].toString(),
          username: user['username'],
          name: employee['name'] ?? '',
          email: user['email'] ?? '',
          phone: employee['mobile'] ?? '',
        );

        _isLoading = false;
        notifyListeners();
        return true;
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
}
