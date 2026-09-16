import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/feature/model/forgot_password_model.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final ApiService apiService;

  ForgotPasswordProvider({required this.apiService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ForgotPasswordResponse? _forgotPasswordResponse;
  ForgotPasswordResponse? get forgotPasswordResponse => _forgotPasswordResponse;

  Future<bool> forgotPassword(String emailOrMobile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndPoints.forgotPassword,
        data: {
          'email_or_mobile': emailOrMobile,
        },
      );

      if (response.statusCode == 200) {
        _forgotPasswordResponse = ForgotPasswordResponse.fromJson(response.data);
        if (_forgotPasswordResponse!.success) {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = _forgotPasswordResponse!.message;
        }
      } else {
        _errorMessage = response.data['message'] ?? 'Something went wrong';
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
