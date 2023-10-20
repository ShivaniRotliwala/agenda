class Validator {
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    if (email.isEmpty) {
      return 'Email can\'t be empty';
    }
    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length <= 6) {
      return 'Password should be greater than 6 characters';
    }

    return null;
  }

  static String? validateConfirmPassword(
      {required String confirmPassword, required String password}) {
    if (confirmPassword.isEmpty) {
      return 'Confirm Password can\'t be empty';
    } else if (confirmPassword != password) {
      return 'Confirm Password doesn\'t match';
    }

    return null;
  }
}
