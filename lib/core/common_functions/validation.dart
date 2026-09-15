class AppValidators {
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'User ID cannot be empty';
    }
    if (value.contains(' ')) {
      return 'User ID cannot contain spaces';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or User ID cannot be empty';
    }
    // If it looks like an email, validate email format
    if (value.contains('@')) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value.trim())) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
