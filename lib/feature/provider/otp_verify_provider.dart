import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/api_end_points.dart';
import 'package:hrms_app/core/service/api_service.dart';
import 'package:hrms_app/feature/model/otp_verify_model.dart';

class OtpVerifyProvider extends ChangeNotifier {
  final ApiService apiService;

  OtpVerifyProvider({required this.apiService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  OtpVerifyResponseModel? _otpVerifyResponse;
  OtpVerifyResponseModel? get otpVerifyResponse => _otpVerifyResponse;

  Future<bool> verifyOtp(String emailOrMobile, String otp) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndPoints.otpVerify,
        data: {
          'email_or_mobile': emailOrMobile,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        _otpVerifyResponse = OtpVerifyResponseModel.fromJson(response.data);
        if (_otpVerifyResponse!.success == true) {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = _otpVerifyResponse!.message;
        }
      } else {
        _errorMessage = response.data['message'] ?? 'Verification failed';
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
