import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/feature/model/reset_password_model.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final ApiService apiService;

  ResetPasswordProvider({required this.apiService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ResetPasswordResponse? _resetPasswordResponse;
  ResetPasswordResponse? get resetPasswordResponse => _resetPasswordResponse;

  Future<bool> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndPoints.resetPassword,
        data: {
          'reset_token': resetToken,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response.statusCode == 200) {
        _resetPasswordResponse = ResetPasswordResponse.fromJson(response.data);
        if (_resetPasswordResponse!.success) {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = _resetPasswordResponse!.message;
        }
      } else {
        _errorMessage = response.data['message'] ?? 'Password reset failed';
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
