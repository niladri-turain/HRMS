class OtpVerifyResponseModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final OtpVerifyData? data;

  OtpVerifyResponseModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponseModel(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: json['data'] != null ? OtpVerifyData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status_code': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class OtpVerifyData {
  final bool? valid;
  final String? resetToken;
  final String? identifier;
  final int? expiresInMinutes;

  OtpVerifyData({
    this.valid,
    this.resetToken,
    this.identifier,
    this.expiresInMinutes,
  });

  factory OtpVerifyData.fromJson(Map<String, dynamic> json) {
    return OtpVerifyData(
      valid: json['valid'],
      resetToken: json['reset_token'],
      identifier: json['identifier'],
      expiresInMinutes: json['expires_in_minutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valid': valid,
      'reset_token': resetToken,
      'identifier': identifier,
      'expires_in_minutes': expiresInMinutes,
    };
  }
}
