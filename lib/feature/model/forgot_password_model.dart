class ForgotPasswordResponse {
  final bool success;
  final int statusCode;
  final String message;
  final ForgotPasswordData? data;

  ForgotPasswordResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? ForgotPasswordData.fromJson(json['data']) : null,
    );
  }
}

class ForgotPasswordData {
  final String identifier;
  final String maskedEmail;
  final int expiresInMinutes;
  final String message;

  ForgotPasswordData({
    required this.identifier,
    required this.maskedEmail,
    required this.expiresInMinutes,
    required this.message,
  });

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordData(
      identifier: json['identifier'] ?? '',
      maskedEmail: json['masked_email'] ?? '',
      expiresInMinutes: json['expires_in_minutes'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
