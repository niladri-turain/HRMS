import 'package:intl/intl.dart';

class Timing {
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  static String getGreetingEmoji() {
    final hour = DateTime.now().hour;
    if (hour < 17) {
      return '😊';
    } else {
      return '🌙';
    }
  }

  static String getCurrentDate() {
    return DateFormat('dd MMM, yyyy').format(DateTime.now());
  }
}
