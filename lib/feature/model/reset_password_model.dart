class ResetPasswordResponse {
  final bool success;
  final int statusCode;
  final String message;

  ResetPasswordResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
