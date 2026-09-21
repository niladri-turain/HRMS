class AppValidators {
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your User ID';
    }
    if (value.contains(' ')) {
      return 'User ID must not contain spaces';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your Email Address or Mobile Number';
    }
    String trimmed = value.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final mobileRegex = RegExp(r'^[0-9]{10,15}$'); // Basic mobile check

    if (trimmed.contains('@')) {
      if (!emailRegex.hasMatch(trimmed)) {
        return 'Please enter a valid email address.';
      }
    } else {
      if (!mobileRegex.hasMatch(trimmed)) {
        return 'Please enter a valid email address or mobile number';
      }
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
