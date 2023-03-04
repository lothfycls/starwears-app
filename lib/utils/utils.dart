import 'package:intl/intl.dart';

class Utils {
  Utils._();

  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String? validateEmail(String? email) {
    // Define a regular expression for email validation
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    // Check if the email matches the regular expression
    if (!emailRegex.hasMatch(email!)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    // Define a regular expression for password validation

    if (password!.length < 8) {
      return "Please enter a valid password";
    }
    return null;
  }
}
